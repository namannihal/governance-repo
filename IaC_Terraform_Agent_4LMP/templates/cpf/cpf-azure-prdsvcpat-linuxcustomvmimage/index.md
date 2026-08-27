# Custom VM Image for Application 
[[_TOC_]]

__Note__: __This repository contains templated codes. Please read through the below documentations to make the code specific to your application.__

This readme provides an overview of a service pattern for Linux Custom VM Image for Application. The solution proposed below provides an easy predefined template built on top of LSEG approved Cloud Products (with identified common configurations) and the service pattern intended to help application teams with rapid creation of managed images from LSEG approved Golden Images.

Here are some of the key advantages the proposed solution offers:

- **Rapid Deployment:** Service patterns are pre-defined templates that can be easily reused which accelerates the deployment process by eliminating the need to write configurations from scratch for each deployment, saving time and effort.
- **Standardization and Consistency:** Service patterns provide standardized templates and best practices for deploying specific infrastructure that promotes consistent configurations. This ensures consistency across deployments, reducing the likelihood of configuration drifts/errors and making it easier to maintain and scale infrastructure.
- **Documentation:** Service pattern comes with built-in documentation that explain the purpose and usage of various components.
- **Security and Compliance:** Service pattern built on top of approved Cloud Products incorporate security best practices and compliance requirements, ensuring that infrastructure is deployed with security in mind from the outset. This reduces the likelihood of security vulnerabilities.
- **Reuse, Sharing and customization:** Teams can share and reuse patterns across projects and organizations. Patterns can be adapted, and customized over time as infrastructure/business requirements change.
- **Version Control:** Patterns can be version-controlled, allowing teams to track changes, roll back to previous configurations if issues arise, and collaborate more effectively through version control systems.

## Pattern Description`

This section contains the details of the azure service technical use case.

The following diagram shows the High Level Architecture diagram for **Service pattern for Custom VM Image for Application**:

[Image: CustomImageforApplicationHLD]

The following diagram shows the High Level Flow diagram for **Service pattern for Custom VM Image for Application**:
[Image: CustomImageforApplicationHLD]

### Identity management

- The identity of the gitlab runner on the subscription recieved as part of subscription vending would be used to create the managed images.

### Secret management

- Application secrets are to be stored in Hashicorp vault provided as part of subscription vending, and the pipeline template has code for retrieving the secrets during pipeline run.


### Availability

- The pattern supports for Zone resilient availability for the managed images created.



# Pattern Usage Guidance


## Pattern Usage

### Pre-requisites

1. Routabe and Non-routable Virtual networks
2. Peering between Routabe and Non-routable Virtual networks
3. Packer container for running the _create-image_ job.
4. Applications secrets injected to the vaults.
5. Application binaries and dependencies should be present in BAMS and they should be security cleared.
6. Destination Azure compute gallery with linux image version.

### Repo structure
[Image: CustomImageforApplicationRepoStructure]

### Build
- Clone the pattern repository to your gitlab project and this can be used as a starter template for your image baking process.
- Pattern assumes that the application has three environments - development, pre production and production. Consumer of the pattern can add or delete environments according to their environment strategy, and the repo can be used as a starter template.
- Three _.env_ files are provided, where azure account, vault address, LMP asset id, runner tag related details can be fed in. _Note_ : If you have gitlab project variables defined with same as the variable name in the pattern, there may be behavioral differences, which can be tweaked by the application team in case of any issues.
An example for dev environment is given below
```
# Development environment configurations

AZURE_ACCOUNT="a1a-51310-dev-test-sub-cpfpub-02"
LSEG_PPE_VAULT="true"
VAULT_ADDR="https://vaultent.ppe.lseg.com"
LMP_ASSET_ID="app-51310"
RUNNER_TAG="a1a_51310_dev_cpfpvt_runner"
```
- The folder _pkrvariables_ contains input variables for each environments. Consumer of the pattern would need to provide the required inputs specific to their subscription and application.An example for dev region is given below.
```
client_id                           = "xxxxx-xxx-43xxx7e-xxxx-xxxxxx"
client_secret                       = ""
tenant_id                           = "xxxxxx-91ec-4cf0-b7a4-c63898072181"
subscription_id                     = "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"
gimage_subscription_id              = "0d03b955-d606-4f60-8550-79c3b700ab22"
virtual_network_name                = "a1a-51310-dev-vnet-nonrtbl-uks-01"
virtual_network_subnet_name         = "a1a-51310-dev-snet-patpe-uks-001"
virtual_network_resource_group_name = "a1a-51310-dev-rg-shared-uks-01"
vm_size                             = "Standard_D2s_v4"
ssh_timeout                         = "5m"
communicator                        = "ssh"
os_type                             = "Linux"
build_resource_group_name           = "a1a-51310-dev-rg-testingpat-uks-03"
gimage_gallery_name                 = "a1a51386devgalgimageuks01"
gimage_gallery_resource_group_name  = "a1a-51386-dev-rg-gimage-uks-01"
gimage_image_version                = "1.0.1"
gimage_image_name                   = "ubuntu-server-20.04-standard-x64-base"
gimage_gallery_name_dest            = "xxxxxxxxxxxxxxxxxxxxxxxxx" 
gimage_image_name_dest              = "xxxxxxxxxxxxxxxxxxxxxxxxx" 
gimage_image_version_dest           = "x.x.x" 
gimage_storage_account_type_dest    = "Standard_LRS" 
managed_image_resource_group_name   = "" 

```
- __Note__: New Golden Image Source Image ID : /subscriptions/0d03b955-d606-4f60-8550-79c3b700ab22/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks02/images/rhel-server-8.8-standard-x64-base

- _config.pkr.hcl_ contains the packer and azure-rm configurations.
- _main.pkr.hcl_ contains the packer code. It has Linux Image build section. Consumer would need to add the installation scripts using security cleared provisioners like Shell, PowerShell etc to install the dependencies. __Note__: If any of the non security cleared provisioners like Ansible needs to be used, then this should be sought exception approvals and clearlisting. The main.pkr.hcl template file currently refers to a Shell provisioner, which executes the scripts inside _provisioners/scripts_ folder in the repository. 
- Script files can be placed in the _provisioners/scripts_ folder in the repository, based on the provisioner used and can be invoked from the _main.pkr.hcl_ file. Scripts folder can be arranged according to the application requirements, and remove unwanted script templates. 
- Current script under _provisioners/scripts/javaTomcatInstallation.sh_ java_tomcat_installation.sh installs java and tomcat and its runtime environment.
- __Note__: There is a deprovision step mentioned in Linux Image builds, and consumer must make sure that the deprovision provisioner needs to run atlast after all the scripts, hence it is placed right at the bottom, never delete or move it to top. To read more about Deprovisioners - https://developer.hashicorp.com/packer/integrations/hashicorp/azure/latest/components/builder/arm#deprovision
```
build {
  name    = "your-application-name"
  sources = ["source.azure-arm.shared_image"]

  # Below provisioner section can be updated specific to application and dependency installations.
  provisioner "shell" {
    script = "./provisioners/scripts/script.sh"
    execute_command  = "{{.Vars}} bash '{{.Path}}'"
  }

  post-processor "manifest" {
      output = "packer-manifest.json"
      strip_path = true
  }
}
```
- Variable definitions, (both packer related and application specific) are present in the _variables.pkr.hcl_ file. When application specific code is built, application specific variables can be placed in the same file.
- _.gitlab-ci.yml_ has the pipeline template which can be run to create the managed images. Pipeline can be treated as a base template pipeline and can be enhanced with application specific details like application name, app versions etc.
```
variables:
  ENVIRONMENT:
    value: "dev"
    options: ["dev", "ppr", "prd"]
    description: "Select your environment"
  APP_VERSION:
    value: "1.0.0"
    options: ["1.0.0", "1.1.0"] # Replace with application versions
    description: "Select Application Version"
  TESTING_REQUIRED:
    value: "No"
    options:  ["No", "Yes"]
    description: "Does the managed image needs testing by deploying a VM pointed to the created image?"
  APP_NAME: "your-app-name" # Replace with the application name
```
The pipeline has five stages.
  - env-mapping     - to map the .env files to pipeline environment
  - azure-auth-lmp  - azure lmp authentication
  - vault-apps-vars - retrieve app secrets from Hashicorp Vault. This section can be seen as a template to retrieve the app secrets and certificates with boiler plate code.
  - create-image    - creating managed image using packer.
  - test-image      - optional stage to test the managed image by deploying using a VM pattern.

  __Note__ : To test the image created using pipeline you would need to change the line 77 - _source_image_id_ field in _.tests/deployTest/a1a-dev-pvt.tfvars_ to "".
  ```
  source_image_id                = "/subscriptions/f733090d-b992-4416-b14a-04279b5442b7/resourceGroups/a1a-51386-dev-rg-gimage-uks-01/providers/Microsoft.Compute/galleries/a1a51386devgalgimageuks01/images/rhel-server-8.8-standard-x64-base"
  ```

  TO

  ```
   source_image_id                = ""
  ```

__Note__ : The third optional stage for retreiving app related secrets is commented now, if you need to store any secrets or certificates, Hashicorp vault provided with subscription vending should be used, and secrets / certificates can be retrieved by uncommenting the 3rd stage - _vault-apps-vars_ , and adding the dependency / need, on to fourth stage - _create-image_ as below.
```
  needs: [01-env-mapping, 02-azure-dynamic-secrets, 03-vault-static-secrets]
  dependencies: [01-env-mapping, 02-azure-dynamic-secrets, 03-vault-static-secrets]
```
  ## Inputs


| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|gimage_gallery_name|Azure compute gallery, where LSEG golden images are present.|string| n/a | Yes|
|gimage_image_name|LSEG golden image name, which should be the base image for image baking.|string| n/a | Yes|
|gimage_image_version|LSEG golden image version.|string| n/a | Yes|
|gimage_gallery_resource_group_name|Resource group where the LSEG golden image gallery is present.|string| n/a | Yes|
|gimage_subscription_id|Subscription Id where the LSEG golden image gallery is present.|string| n/a | Yes|
|gimage_gallery_name_dest|Azure compute gallery, where LSEG golden images are present.|string| n/a | Yes|
|gimage_image_name_dest|LSEG golden image name, which should be the base image for image baking.|string| n/a | Yes|
|gimage_image_version_dest|LSEG golden image version.|string| n/a | Yes|
|gimage_storage_account_type_dest | Specify a storage account type for the Shared Image Gallery Image Version.|string| n/a | Yes|
|client_id|Client Id of the dxone runner.|string| n/a | Yes|
|client_secret|Client secret of the dxone runner, will be fetched in runtime from the vault.|string| n/a | Yes|
|tenant_id|Tenant Id.|string| n/a | Yes|
|subscription_id|The application subscription id.|string| n/a | Yes|
|virtual_network_name|The virtual network where packer temporary vm can be scaffolded to.|string| n/a | Yes|
|virtual_network_subnet_name|The virtual network subnet where packer temporary vm can be scaffolded to.|string| n/a | Yes|
|virtual_network_resource_group_name|Resource group where virtual network for packers temporary vm is part of.If virtual_network_name is set, this value may also be set. If virtual_network_name is set, and this value is not set the builder attempts to determine the resource group containing the virtual network. If the resource group cannot be found, or it cannot be disambiguated, this value should be set.|string| n/a | No|
|managed_image_resource_group_name|Resource group name where the managed image will be created.|string| n/a | Yes|
|os_type|OS type of the requested VM image. eg. Linux |string| n/a | Yes|
|vm_size|Size of the VM used for building.|string| n/a | Yes|
|communicator|Communicator to the VM, it can be ssh or winrm.|string| ssh | No|
|ssh_timeout|The time to wait for SSH to become available.|string| 5m | No|
|build_resource_group_name|Specify an existing resource group to run the build in.|string| n/a | Yes|
|app_name|Name of the application, this value wil be fed in from the pipeline.|string| n/a | Yes|
|app_version|Application version, this value will be fed in from the pipeline.|string| n/a | Yes|
|env|Environment where the build is to bre created for, this value will be fed in from the pipeline.|string| n/a | Yes|


## Additional Information

1. Any non security cleared provisioners should be gone through proper cyber exception approvals to use in the image baking process.
2. The application team would need to check with DxOne team to provision the packer container, for running the _create-image_ job in their application subscription , container registry, or else the _create-image_ job will fail.
3. The current pattern is tested and validated for Linux VM. If you encounter any issues please reach out to the patterns team.
4. For Linux distributions, Packer typically handles the default username and password internally. However, in this implementation, a specific username (packer-user) is passed as a variable. If there's a need to provide or rotate additional credentials, it would involve adding extra variables, securely storing them in the vault, retrieving them during runtime, and replacing the input variables accordingly, following LSEG security standards
5. This pattern now supports publishing images to Azure Compute Gallery, enabling image versioning and regional replication as part of the build process.
## Changelog

- [azure_prdsvc_packer_customvmimageforapplication](CHANGELOG.md)

## References
- Packer ARM documentation - https://developer.hashicorp.com/packer/integrations/hashicorp/azure/latest/components/builder/arm
- Packer SSH communicator documentation (Please refer for Linux guidances) - https://developer.hashicorp.com/packer/docs/communicators/ssh
