---
version: 1.3.1
available_versions:
  - 1.3.1
  - 1.3.0
  - 1.2.4
  - 1.2.3
  - 1.2.2
---

<!-- BEGIN_TF_DOCS -->
# Web Application Firewall Policy module

## Overview

This terraform module creates a Web Application Firewall Policy and associated resources. Web Application Firewall Policies contain all the WAF settings and configurations.This includes custom rules, managed rules, and so on.

## Prerequisites

An existing `resource_group`

## Guidance

#### Usage

###### AzureRM 3.x to 4.x Upgrade Notes for Web Application Firewall Policy

Product Impact -- LOW

- Updated `azurerm` provider version to 4.x.
- Wiki link for [AzureRM 4.x Upgrade](https://gitlab.dx1.lseg.com/groups/app/app-51310/azure/prdsvc/terraform/-/wikis/Terraform-AzureRM-Provider-Upgrade:-Version-3.x-to-4.x/Web-application-firewall-policy) for details on the upgrade process.
- For more details, refer to the official [AzureRM 4.x Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide)

###### Others

- Global WAF policy: When you associate a WAF policy globally, every site behind your Application Gateway WAF is protected with the same managed rules, custom rules and any other configured settings.
- Per-site WAF policy: With per-site WAF policies, you can protect multiple sites with differing security needs behind a single WAF by using per-site policies.
- Per-URI policy: For even more customization down to the URI level, you can associate a WAF policy with a path-based rule. If there are certain pages within a single site that require different policies, you can make changes to the WAF policy that only affect a given URI.
- All new Web Application Firewall's WAF settings (custom rules, managed rule set configurations and so on.) exist in a WAF policy. If you have an existing WAF, these settings may still exist in your WAF configuration.

#### Security Considerations

- To align with security controls for this product we have removed the manage ruleset override option from our code, as overriding the manage ruleset is not the requirement as this moment.
- To implement controls AZU-AGW-SC_170 and AZU-AGW-SC_180, a default rate limit rule is added by default at priority 10 with rate_limit_duration  = "OneMin" and default_rate_limit_threshold variablized with default as 2000 with match condition and group by as below

group_rate_limit_by = "ClientAddr"
   match_conditions = {
     mc1 = {
       match_values       = ["0.0.0.0"]
       operator           = "IPMatch"
       negation_condition = false
       transforms         = null
       match_variables = {
         mv1 = {
           variable_name = "RemoteAddr"
           selector      = null
         }
       }
     }
   }

- The match conditions and group by properties for this default rule can be updated by application team (only if required), based on application requirement by setting variable default_rate_limit_rule_property
- It is strictly advised to create any new allow match rule or rate limit rule with priority lesser (11-100) than this rule in order to adhere to these security controls.

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AGW-SC_040 | Web Application Firewall Policy must be in prevention mode |  Web Application Firewall Policy must be in prevention mode (What) in the Overview settings (How) to ensure that the WAF will block malicious requests (Why) | True | True | in policy_setting block  the "mode" attribute value hardcoded with "Prevention". |
| 2. | AZU-AGW-SC_050 |  The latest Microsoft DefaultRuleSet must be enabled | The latest Microsoft DefaultRuleSet must be enabled (What) in the Managed rules settings (How) in order to protect against known and new attacks against web applications (Why) | True | True | Added a local variable for Microsoft DefaultRuleSet with latest version (2.2) |
| 3. | AZU-AGW-SC_051 |   Microsoft Default Ruleset managed rule actions must be set to Block as a default or Anomaly Score in accordance with application requirements, Log Only must only be used when it has been shown that when configured to Block/Anomaly Score the application does not correctly function and it has been shown that it is not possible to alter the application to be compatible with Block/Anomaly Score |  Microsoft Default Ruleset managed rule actions must be set to Block as a default or Anomaly Score in accordance with application requirements, Log Only must only be used when it has been shown that when configured to Block/Anomaly Score the application does not correctly function and it has been shown that it is not possible to alter the application to be compatible with Block/Anomaly Score (What) via the Managed Rules settings (How) to ensure the maximum level of protection is provided by the WAF (Why) | False | False | Control implemented by technical configuration setting: False |
| 4. | AZU-AGW-SC_052 |  The latest Microsoft BotRuleSet must be enabled | The latest Microsoft BotRuleSet must be enabled (What) in the Managed rules settings (How) in order to protect against bot attacks against web applications (Why) | False | True | This control will be implemented by using the `local.merged_rule_set` variable, which allows custom web application firewall rule sets. Current azurerm 4.x.x support Microsoft BotRuleSet version 1.1 |
| 5. | AZU-AGW-SC_053 |  Managed Bot Ruleset default actions must not be changed | Managed Bot Ruleset default actions must not be changed (What) in the Managed rules settings (How) in order to main the integrity of predefined protection measures (Why) | True | True |By default, Microsoft_DefaultRuleSet and Microsoft_BotManagerRuleset values are hardoced within merged_rule_set locals block and further looping done over locals block ensuring Microsoft_DefaultRuleSet and Microsoft_BotManagerRuleset values cannot be changed. |
| 6. | AZU-AGW-SC_060 | All managed rules must be enabled | All managed rules must be enabled (What) in the Managed ruleset settings (How) to ensure that the maximum protection is in place to prevent malicious traffic from reaching the protected services (Why) | True | True |  This control already implemeted using AZU-AGW-SC_050 security, when we installed the latest OWASP and Microsoft bot manage rule, all the manage rules are by default enabled. |
| 7. | AZU-AGW-AU_030 | Log scrubbing must be enabled |  Log scrubbing must be enabled (What) in the Sensitive data settings (How) to prevent sensitive data and PII being stored within the WAF logs (Why) | True | True | set the default value of enable attribute as true under log scrubbing block |
| 8. | AZU-AGW-SC_070 | An Application Gateway instance must only contain backend pools from the same Product Line and same environment |  An Application Gateway instance must only contain backend pools from the same Product Line and same environment (What) in the Deployment settings (How) to reduce the blast radius should an Application Gateway be misconfigured or compromised (Why) | False | False | Control implemented by technical configuration setting: False  |
| 9. | AZU-AGW-SC_100 | Request body must be inspected | Request body must be inspected (What) in the Policy settings (How) to ensure that the HTTP payload is inspected/evaluated (Why) | True | True | Control implemented by setting `request_body_check = true` in `policy_setting` block. |
| 10. | AZU-AGW-SC_160 | Requests should only be accepted from clear listed IP addresses for those applications where this is applicable and the IP addresses are known | Requests should only be accepted from clear listed IP addresses for those applications where this is applicable and the IP addresses known (What) in the Custom rule settings (How) to reduce the service exposure to potential bad actors on the internet (Why) | True | False | Control implemented by creating a local variable to create a default custom rule with rule_type as `MatchRule` and action as `Block` with `match_values` as ["0.0.0.0/0"] |
| 11. | AZU-AGW-SC_090 | A Web Application Firewall Policy must only be associated with one listener | A Web Application Firewall Policy must only be associated with one listener (What) in the Association settings (How) to ensure the most secure configuration for each listener (Why) | False | False | The listener and web application firewall policy association is being done in application gateway module. In the Http+listener block of application gateway, pass the `firewall_policy_id`. |
| 12. | AZU-AGW-SC_170 | Application Gateway WAFs must have a rate limiting rule defined | Application Gateways WAFs must have a rate limiting rule defined (What) in the Custom rule settings (How) to prevent denial of service attacks (Why) | True | True | Control implemented by creating a local variable to create a default custom rule with rule_type as `rate_limit` with `default_rate_limit_threshold` variablized (default: 2000), as per security control number `AZU-AGW-SC_180`, however the match condition configuration for this default rule can be tweaked if need as per the application requirement. Please check the `Note` section to create a new `rate_limit_rule` and `Match_rule` on top of this default `rate_limit_rule` |
| 13. | AZU-AGW-SC_180 | Application Gateway WAFs should have a rate limiting rule defined that is set to no more than 2000 requests per minute |  Application Gateway WAFs should have a rate limiting rule defined that is set to no more than 2000 requests per minute (How) to prevent denial of service attacks (Why) | True | True | Control implemented by setting a default rule with `rate_limit_duration  = "OneMin"` and `default_rate_limit_threshold` variablized with default as `2000`. |
| 14. | AZU-AGW-SC_200 | Application Gateway Application Firewall Policies must not have exclusions specified | Application Gateway Application Firewall Policies must not have exclusions specified (What) in the Managed Rules settings (How) to prevent traffic bypassing Managed Rules (Why) | True | False | The exclusion block option has been added in the `manage_rule` block as per approval from security. |

## SMCF Controls

| S. No.  | Control Objective | Control Sub-Objective | Implementation Type | Implementation status | Comments |
|---------|-------------------|-----------------------|---------------------|-----------------------|----------|
| 1. | [SMCF-GOV-02: Naming Convention](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/850/SMCF-GOV-02-Naming-Convention) | SMCF-GOV-02-03: Comply with the limitations and restrictions imposed by the cloud provider for different resource types.<br><br>SMCF-GOV-02-04: Capture the key pieces of information that are relevant for the resource, such as environment, location, function, owner, etc.<br><br>SMCF-GOV-02-05: Use a standard format and separator for the resource names, such as letters, numbers, and hyphens. | IaC<br><br>Documentation | True | This control will be implemented using resource naming module.<br>[azure-prdsvc-terraform-resourcenames](https://gitlab.dx1.lseg.com/app/app-51310/azure/prdsvc/terraform/azure-prdsvc-terraform-resourcenames) |
| 2. | [SMCF-GOV-03: Tagging Model](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/810/SMCF-GOV-03-Tagging-Model) | SMCF-GOV-03-02: Must apply tags to all deployed resources, where applicable. | IaC<br><br>Policy | True | This control will be implemented using `tags` parameter.<br><br>This control is achieved by custom policy as described in the [clear listing page](https://dev.azure.com/LSEGroup/Foundation/_git/azu-plat-policy) from where it inherits all the mandatory tags. |
| 3. | [SMCF-GOV-08: Resource Configuration](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1250/SMCF-GOV-08-Resource-Configuration) | SMCF-GOV-08-01: Enforce resource configuration and properties.<br><br>SMCF-GOV-08-02: Enforce resource security baseline configuration. | Policies<br><br>Iac<br><br>Policies<br><br>Iac | True | This control will be implemented by having all the `Mandate` and most of the `Optional ` parameters as part of resource development and configurations.<br><br>This control will be implemented by having all the possible `Security Controls` configured. These are further validated using `Pester Test Cases` and `Azure Policy`. |
| 4. | [SMCF-OPS-03 Resource Logging & Monitoring](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1427/SMCF-OPS-03-Resource-Logging-Monitoring) | SMCF-OPS-03-02: Define and automate resource operation and security log collection<br><br>SMCF-OPS-03-03: Define and implement workload Service Level Objectives (SLOs) and Service Level Indicators (SLIs) | Policy<br><br>Documentation<br><br>Documentation | True | This control will be implemented by `DINE` Policy.<br><br>[Require Resource Logs](https://learn.microsoft.com/en-us/azure/web-application-firewall/shared/waf-azure-policy#require-resource-logs)<br><br>[Cloud monitoring service level objectives ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/service-level-objectives)<br><br>[Monitor Application Gateway WAF](https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/application-gateway-waf-metrics)<br><br>[Supported Metrics for Application Gateway](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-network-applicationgateways-metrics) |
| 5.| [SMCF-OPS-06: BCDR Plan](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1433/SMCF-OPS-06-BCDR-Plan) | SMCF-OPS-06-03: Design workload with the appropriate BCDR technologies and solutions that meet the RTO, RPO and SLA requirements | IaC<br><br>Documentation | True | This control will be implemented in Application Gateway Module using the block `autoscale_configuration` with in the resource type `azurerm_application_gateway`. If autoscaling is not required, users can use capacity to configure the desired capacity. <br><br>[Scaling Application Gateway v2 and WAF v2 ](https://learn.microsoft.com/en-us/azure/application-gateway/application-gateway-autoscaling-zone-redundant) |
| 6. | [SMCF-OPS-07: Resource Protection](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1435/SMCF-OPS-07-Resource-Protection) | SMCF-OPS-07-01: Prevent accidental or malicious deletion of production resources<br><br>SMCF-OPS-07-02: Prevent accidental misconfiguration of key production resources | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard based on application team requirement. <br><br>[Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json) |
| 7. | [SMCF-SEC-05 Access Management](https://dev.azure.com/lseg/Foundation/_wiki/wikis/Cloud%20Service%20Management%20Control%20Framework/1445/SMCF-SEC-05-Access-Management) | SMCF-SEC-05-03: Grant access based on appropriate review of business justification and approvals | IaC<br><br>Documentation | False | This control will be implemented as per LSEG Standard where RBAC and IAM are Handled via access package and has a JIT implementation in place. <br><br>[RBAC built-in roles ](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) |

## Changelog

[azure-prdsvc-terraform-webapplicationfirewallpolicy](CHANGELOG.md)

## References

### Microsoft Docs

-[Official Documentation](https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/policy-overview)

### Terraform Docs

[azurerm\_web\_application\_firewall\_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=4.33 |

## Resources

| Name | Type |
|------|------|
| [azurerm_web_application_firewall_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_custom_rules"></a> [custom_rules](#input_custom_rules) | (Optional) One or more custom_rules blocks as defined below.<br/>object({<br/>name                           = (optional) Gets name of the resource that is unique within a policy. This name can be used to access the resource.<br/>priority                       = (Required) Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.<br/>rule_type                      = (Required) Describes the type of rule. Possible values are `MatchRule` and `Invalid`.<br/>action                         = (Required) Type of action. Possible values are `Allow`, `Block` and `Log`.<br/>enabled                        = (Optional) Describes if the policy is in enabled state or disabled state. Defaults to true.<br/>rate_limit_threshold           = (Optional) Specifies the threshold value for the rate limit policy. Must be greater than or equal to 1 if provided.<br/>rate_limit_duration            = (Optional) Specifies the duration for the rate limit policy.<br/>group_rate_limit_by            = (Optional) Specifies what grouping the rate limit will count requests by. Possible values are GeoLocation, ClientAddr and None.<br/>match_condition                = map(object({<br/>match_values                   = (Required) A list of match values.<br/>operator                       = (Required) Describes operator to be matched. Possible values are IPMatch, GeoMatch, Equal, Contains, LessThan, GreaterThan, LessThanOrEqual, GreaterThanOrEqual, BeginsWith, EndsWith and Regex.<br/>negation_condition             = (Required) Describes if this is negate condition or not.<br/>transforms                     = (Optional) A list of transformations to do before the match is attempted. Possible values are HtmlEntityDecode, Lowercase, RemoveNulls, Trim, UrlDecode and UrlEncode.<br/>}))<br/>match_variable                 = map(object({<br/>variable_name                  = (Required) The name of the Match Variable. Possible values are RemoteAddr, RequestMethod, QueryString, PostArgs, RequestUri, RequestHeaders, RequestBody and RequestCookies.<br/>selector                       = (Optional) Describes field of the matchVariable collection<br/>}))<br/>)} | <pre>map(object({<br/>    # Required<br/>    action    = string<br/>    priority  = number<br/>    rule_type = string<br/>    # Optional<br/>    name                 = optional(string)<br/>    enabled              = optional(bool)<br/>    rate_limit_threshold = optional(number, 1)<br/>    rate_limit_duration  = optional(string)<br/>    group_rate_limit_by  = optional(string)<br/>    match_conditions = map(object({<br/>      match_values       = optional(list(string))<br/>      operator           = string<br/>      negation_condition = optional(bool)<br/>      transforms         = optional(list(string))<br/>      match_variables = map(object({<br/>        variable_name = string<br/>        selector      = optional(string)<br/>      }))<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_default_rate_limit_rule_property"></a> [default_rate_limit_rule_property](#input_default_rate_limit_rule_property) | (Optional) A default rate limit rule property block as defined below.<br/>object({<br/>group_rate_limit_by = (Optional) Specifies what grouping the rate limit will count requests by. Possible values are GeoLocation, ClientAddr and None.<br/>match_condition     = map(object({<br/>    match_values       = (Required) A list of match values.<br/>    operator           = (Required) Describes operator to be matched. Possible values are IPMatch, GeoMatch, Equal, Contains, LessThan, GreaterThan, LessThanOrEqual, GreaterThanOrEqual, BeginsWith, EndsWith and Regex.<br/>    negation_condition = (Required) Describes if this is negate condition or not.<br/>    transforms         = (Optional) A list of transformations to do before the match is attempted. Possible values are HtmlEntityDecode, Lowercase, RemoveNulls, Trim, UrlDecode and UrlEncode.<br/>}))<br/>match_variable = map(object({<br/>    variable_name = (Required) The name of the Match Variable. Possible values are RemoteAddr, RequestMethod, QueryString, PostArgs, RequestUri, RequestHeaders, RequestBody and RequestCookies.<br/>    selector      = (Optional) Describes field of the matchVariable collection<br/>}))<br/>)} | <pre>object({<br/>    group_rate_limit_by = optional(string)<br/>    match_conditions = map(object({<br/>      match_values       = optional(list(string))<br/>      operator           = string<br/>      negation_condition = optional(bool)<br/>      transforms         = optional(list(string))<br/>      match_variables = map(object({<br/>        variable_name = string<br/>        selector      = optional(string)<br/>      }))<br/>    }))<br/>  })</pre> | <pre>{<br/>  "group_rate_limit_by": "ClientAddr",<br/>  "match_conditions": {<br/>    "mc1": {<br/>      "match_values": [<br/>        "0.0.0.0"<br/>      ],<br/>      "match_variables": {<br/>        "mv1": {<br/>          "selector": null,<br/>          "variable_name": "RemoteAddr"<br/>        }<br/>      },<br/>      "negation_condition": false,<br/>      "operator": "IPMatch",<br/>      "transforms": null<br/>    }<br/>  }<br/>}</pre> | no |
| <a name="input_default_rate_limit_threshold"></a> [default_rate_limit_threshold](#input_default_rate_limit_threshold) | (Optional) Specifies the threshold value for the default rate limit rule. | `number` | `2000` | no |
| <a name="input_enable_bot_manager_rules"></a> [enable_bot_manager_rules](#input_enable_bot_manager_rules) | (Optional) Enable or disable Bot Manager rules. When set to false, Microsoft_BotManagerRuleSet will not be applied to the WAF policy. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_exclusion"></a> [exclusion](#input_exclusion) | (Optional) an exclusion block to exclude the rules from manage rule<br/>map(object({<br/>match_variable          =  (Required) The name of the Match Variable. Possible values: RequestArgKeys, RequestArgNames, RequestArgValues, RequestCookieKeys, RequestCookieNames, RequestCookieValues, RequestHeaderKeys, RequestHeaderNames, RequestHeaderValues.<br/>selector                =  (Required) Describes field of the matchVariable collection.<br/>selector_match_operator = (Required) Describes operator to be matched. Possible values: Contains, EndsWith, Equals, EqualsAny, StartsWith.<br/>excluded_rule_set       = object({<br/>type       = (Optional) The rule set type. The only possible value include Microsoft_DefaultRuleSet and OWASP. Defaults to OWASP.<br/>version    = (Optional) The rule set version. The only possible value include 2.2 (for rule set type Microsoft_DefaultRuleSet) and 3.2 (for rule set type OWASP). Defaults to 3.2.<br/>rule_group = map(object({<br/>rule_group_name =  (Required) The name of rule group for exclusion.<br/>excluded_rules  =  (Optional) One or more Rule IDs for exclusion.<br/>}))<br/>})<br/>})) | <pre>map(object({<br/>    match_variable          = string<br/>    selector                = string<br/>    selector_match_operator = string<br/>    excluded_rule_set = object({<br/>      type    = optional(string, null)<br/>      version = optional(string, null)<br/>      rule_group = map(object({<br/>        rule_group_name = string<br/>        excluded_rules  = optional(list(string), [])<br/>      }), )<br/>    })<br/>  }))</pre> | `{}` | no |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_manage_rule_set"></a> [manage_rule_set](#input_manage_rule_set) | (Optional) The managed_rule_set block supports the following:<br/>    type = (Optional) The rule set type. Possible values: Microsoft_BotManagerRuleSet, Microsoft_DefaultRuleSet and OWASP. Defaults to OWASP.<br/>    version = (Required) The rule set version. Possible values: 0.1, 1.0, 1.1, 2.1, 2.2, 2.2.9, 3.0, 3.1 and 3.2.4<br/>    rule_group_override = (Optional) List of objects:<br/>      rule_group_name     = (Required) The name of the rule group for override<br/>      rule = (Optional) List of objects:<br/>        id = (Required) Identifier for the managed rule.<br/>        enabled = (Optional) Describes if the managed rule is in enabled state or disabled state.<br/>        action  = (Optional) Describes the override action to be applied when rule matches. Possible values are Allow, AnomalyScoring, Block and Log. | <pre>map(object({<br/>    type    = optional(string)<br/>    version = string<br/>    rule_group_override = optional(list(object({<br/>      rule_group_name = string<br/>      rule = optional(list(object({<br/>        id      = string<br/>        enabled = optional(bool, false)<br/>        action  = optional(string)<br/>      })), [])<br/>    })), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_policy_settings"></a> [policy_settings](#input_policy_settings) | object({<br/>    enabled                                   = (Optional) Describes if the policy is in enabled state or disabled state. Defaults to true.<br/>    file_upload_limit_in_mb                   = (Optional) The File Upload Limit in MB. Accepted values are in the range 1 to 4000. Defaults to 100.<br/>    max_request_body_size_in_kb               = (Optional) The Maximum Request Body Size in KB. Accepted values are in the range 8 to 2000. Defaults to 128.<br/>    request_body_inspect_limit_in_kb          = (Optional) Specifies the maximum request body inspection limit in KB for the Web Application Firewall. Defaults to 128.<br/>    request_body_enforcement                  = (Optional) Whether the firewall should block a request with body size greater then max_request_body_size_in_kb. Defaults to false.<br/>    file_upload_enforcement                   = (Optional) Whether the firewall should block a request with upload size greater then file_upload_limit_in_mb. Defaults to true.<br/>    js_challenge_cookie_expiration_in_minutes = (Optional) Specifies the JavaScript challenge cookie validity lifetime in minutes. The user is challenged after the lifetime expires. Accepted values are in the range 5 to 1440. Defaults to 30.<br/>    log_scrubbing                    = object({<br/>    enabled                          = (Optional) Whether the log scrubbing is enabled or disabled. Defaults to true.<br/>    scrubbing_rule                   = map(object({<br/>      enabled                          = (Optional) Whether this rule is enabled. Defaults to true.<br/>      match_variable                   = (Required) Specifies the variable to be scrubbed from the logs. Possible values are RequestHeaderNames, RequestCookieNames, RequestArgNames, RequestPostArgNames, RequestJSONArgNames and RequestIPAddress.<br/>      selector_match_operator          = (Required) Specifies the variable to be scrubbed from the logs. Possible values are RequestHeaderNames, RequestCookieNames, RequestArgNames, RequestPostArgNames, RequestJSONArgNames and RequestIPAddress.<br/>      selector                         = (Optional) Specifies which elements in the collection this rule applies to.<br/>      }))<br/>    })<br/>  }) | <pre>object({<br/>    enabled                                   = optional(bool)<br/>    file_upload_limit_in_mb                   = optional(number)<br/>    max_request_body_size_in_kb               = optional(number)<br/>    request_body_inspect_limit_in_kb          = optional(number)<br/>    request_body_enforcement                  = optional(bool, false)<br/>    file_upload_enforcement                   = optional(bool, true)<br/>    js_challenge_cookie_expiration_in_minutes = optional(number)<br/>    log_scrubbing_rule = optional(map(object({<br/>      enabled                 = optional(bool)<br/>      match_variable          = string<br/>      selector_match_operator = optional(string)<br/>      selector                = optional(string)<br/>    })), null)<br/>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_http_listener_ids"></a> [http_listener_ids](#output_http_listener_ids) | A list of HTTP Listener IDs from an azurerm_application_gateway. |
| <a name="output_id"></a> [id](#output_id) | The ID of the created Web Application Firewall Policy. |
| <a name="output_name"></a> [name](#output_name) | The Name of the created Web Application Firewall Policy. |
| <a name="output_path_based_rule_ids"></a> [path_based_rule_ids](#output_path_based_rule_ids) | A list of URL Path Map Path Rule IDs from an azurerm_application_gateway. |
| <a name="output_resource"></a> [resource](#output_resource) | The Web Application Firewall Policy resource. |
<!-- END_TF_DOCS -->
