# Artifact Management and Signing

**Publishing to Artifactory:** 

Built artifacts should be uploaded to the enterprise artifact repository. For guidance, read this [guide on using enterprise Artifactory](https://lsegroup.sharepoint.com/sites/DXOne-Tools/SitePages/How-to-Guide---Enterprise-Artifactory.aspx).

**Using GPG keys for signing:**

GPG keys are generated together with access tokens when an app ID is onboarded to DXOne.
 
The GPG key itself is stored in Artifactory, but the unique name of the key is stored in Hashicorp Vault so the team can retrieve it and use it through a pipeline without it being hardcoded. For guidance on retrieving the key name, read this [guide on secrets retrieval](https://lsegroup.sharepoint.com/sites/DXOne-Tools/SitePages/How-to-Guide---Enterprise-Artifactory.aspx#2.3-secrets-retrieval).

The key name is associated with a GPG key for your app, stored in Artifactory, that can specify to be used to sign artifacts through Release bundles feature, [use of a GPG key is demoed here](https://lsegroup.sharepoint.com/sites/DXOne-Tools/SitePages/How-to-Guide---Enterprise-Artifactory.aspx#2.1-overview-of-demo-pipeline).

**Using signing certificates:**

An alternative method to keys is to use signing certificates. If you require this for your app, there is a Service Now form for this: [Code Signing Certificate Request for executables and scripts - Support Hub Login - Support Hub](https://lseg.service-now.com/esc?id=sc_cat_item&sys_id=fd5372c397d9bd9441c03d9e2153af5f).
