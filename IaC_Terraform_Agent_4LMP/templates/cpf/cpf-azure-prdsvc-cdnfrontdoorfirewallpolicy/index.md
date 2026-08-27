---
version: 1.1.0
available_versions:
  - 1.1.0
  - 1.0.2
  - 1.0.1
  - 1.0.0
  - 0.9.1
---

<!-- BEGIN_TF_DOCS -->
# Azure CDN Front Door Firewall Policy module

## Overview

This terraform module creates a Front door Firewall Policy with custom and managed rules.

## Prerequisites

## Guidance

#### Usage

- <b>IMPORTANT</b>:

  - A default `custom_rule` of type `RateLimitRule` is provided to adhere to security controls.
  - The hardcoding to the tyoe being `RateLimitRule` is removed, thus facilitiating any other rule type can be added to this object as per usecase.
  - The `name, enabled and type` of the `default custom_rule` is hardcoded in locals, but other parameters are left to user discretion.
  - Make sure the `priority` of the default rule is higher than the others as it is a RateLimitRule.

- This module creates below resource in Azure
  - Azure Firewall Policy with manage and custom rule
- The `Standard_AzureFrontDoor` Firewall Policy sku may contain custom rules only. The `Premium_AzureFrontDoor` Firewall Policy sku may contain both custom and managed rules.
- When run in Detection mode, the Front Door Firewall Policy doesn't take any other actions other than monitoring and logging the request and its matched Front Door Rule to the Web Application Firewall logs.
- The module support the latest version of `Microsoft_BotManagerRuleSet` and `default_ruleset` managed rule.In case of new version of these manage rule gets available the code has to be updated with the newer version accordingly.

#### Security Considerations

## Security Controls

| S. No.  | Control ID | Control Title | Description | Implemented | Tested using Pester | Comments |
|---------|------------|---------------|-------------|-------------|---------------------|----------|
| 1. | AZU-AFD-SC_010  | Front Door WAF policy must be enabled | Front Door WAF policy must be enabled (What) within Overview, Enable/Disable switch (How) in order to apply managed rules to protect websites (Why)| True | True | Implemented using `enabled` argument set to `true`. |
| 2. | AZU-AFD-SC_020 | Front Door WAF policy must be in prevention mode | Front Door WAF policy must be in prevention mode (What) within Overview, Switch to mode (How) in order to block web application attacks (Why)| True | True | Implemented by setting `mode` parameter to `Prevention`. |
| 3. |  AZU-AFD-SC_030 |The latest Microsoft DefaultRuleSet must be enabled | The latest Microsoft DefaultRuleSet must be enabled (What) within Managed rules, Assign (How) in order to protect against known and new attacks against web applications (Why) | True | True | Implemented using latest `Microsoft_defaultruleset` version `2.2`. |
| 4. | AZU-AFD-SC_031 | The Microsoft DefaultRuleSet anomaly score action must be set to block | The Microsoft DefaultRuleSet anomaly score action must be set to block (What) within Managed rules, Assign (How) to ensure the maximum level of protection is provided by the WAF (Why) | True | False | Implemented latest `Microsoft_defaultruleset`, set action to `Block` |
| 5. | AZU-AFD-SC_032 | The latest Microsoft BotRuleSet must be enabled | The latest Microsoft DefaultRuleSet must be enabled (What) within Managed rules, Assign (How) to protect against known and new attacks against web applications (Why) | True | True |  Implemented using latest  `Microsoft_BotManagerRuleSet` version `1.1` |
| 6. | AZU-AFD-SC_040 | Managed Ruleset WAF rule actions must be set to 'Block on Anomaly' as a default or 'Anomaly Score' in accordance with application requirements, 'Log Only' must only be used if the WAF rule is incompatible with application functionality | Managed Ruleset WAF rule actions must be set to 'Block on Anomaly' as a default or 'Anomaly Score' in accordance with application requirements, 'Log Only' must only be used if the WAF rule is incompatible with application functionality (What) via the Managed Rules settings (How) to ensure the maximum level of protection is provided by the WAF (Why) | True | False | Added `action` parameter in `default_ruleset_exclusions` variable to support overriding rule actions for applications incompatible with 'Block on Anomaly' |
| 7. | AZU-AFD-SC_041 | All managed rules that are enabled by default must not be disabled |  All managed rules that are enabled by default must not be disabled (What) within Managed rules settings (How) to ensure that the maximum protection is in place to prevent malicious traffic from reaching the protected services (Why) | True | False | Set rule set action to `Block` |
| 8. | AZU-AFD-SC_042 | Application specific managed rules must be enabled | Managed rules that protected a specific hosted backend application (i.e. Spring Cloud, Apache Struts) must be enabled (What) within Managed rules settings (How) to ensure that application specific protection is in place to prevent malicious traffic from reaching the protected services (Why) | False | False | Control implemented : False. |
| 9. | AZU-AFD-SC_043 | Managed Bot Ruleset rule default actions must not be changed | Managed Bot Ruleset rule default actions must not be changed (What) in the Managed Rules settings (How) to ensure that the maximum protection is in place to prevent malicious traffic from reaching the protected services (Why) | True | False | Set rule set action to `Block` |
| 10. | AZU-AFD-SC_050 | HTTP request body inspection must be enabled | HTTP request body inspection must be enabled (What) within Policy settings (How) in order to inspect the HTTP payload for threats (Why) | False | False | This control couldn't be implement via terraform. |
| 11. | AZU-AFD-SC_140 | Front Door WAF policy must have rate limiting configured | Front Door WAF policy must have rate limiting configured (What) within Custom rules (How) in order to detect and block abnormally high levels of traffic (Why) | True | True | Implemented using `Custom_rule` type value set to `RateLimitRule`. |
| 12. | AZU-AFD-SC_180 | Front Door Web Application Firewall Policies must change the default Block Response Status Code to 200 | Front Door Web Application Firewall Policies must change the default Block Response Status Code to 200 (What) in the Policy settings (How) to avoid giving any unnecessary information to an attacker (Why) | True | True | Implemented using variable `custom_block_response_status_code` argument value set to `200`. |
| 13. | AZU-AFD-SC_190 | Front Door Web Application Firewall Policies must not have exclusions specified | Front Door Web Application Firewall Policies must not have exclusions specified (What) in the Managed Rules settings (How) to prevent traffic bypassing Managed Rules (Why) | True | True | To implement this control made exclusion block is optional in code. |

## Changelog

- [azure-prdsvc-terraform-cdnfrontdoorfirewallpolicy](CHANGELOG.md)

## References

### Microsoft Docs

- [Official Documentation](https://learn.microsoft.com/en-us/azure/web-application-firewall/afds/afds-overview)

### Terraform Docs

- [azurerm_cdn_frontdoor_firewall_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_firewall_policy)

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
| [azurerm_cdn_frontdoor_firewall_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_firewall_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app_id](#input_app_id) | (Required) A descriptive name (abbreviation) for the workload (application) as it is registered in Leanix. The identifier format in Leanix is 'APP-12345', for the purpose of naming resources only 5 number will be used. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input_context) | (Optional) Application context information for the resource(s) (max 10 chars). | `string` | `null` | no |
| <a name="input_custom_block_response_body"></a> [custom_block_response_body](#input_custom_block_response_body) | (Optional) If a custom_rule block's action type is block, this is the response body. The body must be specified in base64 encoding | `string` | `null` | no |
| <a name="input_custom_block_response_status_code"></a> [custom_block_response_status_code](#input_custom_block_response_status_code) | (Optional) If a custom_rule block's action type is block, this is the response status code. Possible values are 200, 403, 405, 406, or 429 | `number` | `200` | no |
| <a name="input_custom_rules"></a> [custom_rules](#input_custom_rules) | (Optional) map(object({<br/>  name                           = "(Required) Gets name of the resource that is unique within a policy. This name can be used to access the resource."<br/>  action                         = "(Required) The action to perform when the rule is matched. Possible values are Allow, Block, Log, or Redirect."<br/>  rule_type                      = (Required) Describes the type of rule. Possible values are `MatchRule` and `RateLimitRule`.<br/>  enabled                        = "(Optional) Is the rule is enabled or disabled? Defaults to true."<br/>  priority                       = "(Optional) The priority of the rule. Rules with a lower value will be evaluated before rules with a higher value. Defaults to 1."<br/>  rate_limit_duration_in_minutes = "(Optional) The rate limit duration in minutes. Defaults to 1."<br/>  rate_limit_threshold           = "(Optional) The rate limit threshold. Defaults to 10."<br/>  match_condition = (Optional) list(object({<br/>    match_variable     = "(Required) The request variable to compare with. Possible values are Cookies, PostArgs, QueryString, RemoteAddr, RequestBody, RequestHeader, RequestMethod, RequestUri, or SocketAddr."<br/>    match_values       = "(Required) Up to 600 possible values to match. Limit is in total across all match_condition blocks and match_values arguments. String value itself can be up to 256 characters in length."<br/>    operator           = "(Required) Comparison type to use for matching with the variable value. Possible values are Any, BeginsWith, Contains, EndsWith, Equal, GeoMatch, GreaterThan, GreaterThanOrEqual, IPMatch, LessThan, LessThanOrEqual or RegEx."<br/>    selector           = "(Optional) Match against a specific key if the match_variable is QueryString, PostArgs, RequestHeader or Cookies."<br/>    negation_condition = "(Optional) Should the result of the condition be negated."<br/>    transforms         = "(Optional) Up to 5 transforms to apply. Possible values are Lowercase, RemoveNulls, Trim, Uppercase, URLDecode or URLEncode."<br/>  }))<br/>})) | <pre>map(object({<br/>    name   = string<br/>    action = string<br/>    type   = string<br/>    # Optional<br/>    enabled                        = bool<br/>    priority                       = number<br/>    rate_limit_duration_in_minutes = optional(number)<br/>    rate_limit_threshold           = optional(number)<br/>    match_condition = optional(list(object({<br/>      match_variable     = string<br/>      match_values       = list(string)<br/>      operator           = string<br/>      selector           = string<br/>      negation_condition = bool<br/>      transforms         = list(string)<br/>    })))<br/>  }))</pre> | `{}` | no |
| <a name="input_default_rate_limit_rule"></a> [default_rate_limit_rule](#input_default_rate_limit_rule) | A default rule of RateLimitRule type is given by default - <br/>  (Optional) map(object({<br/>    action                         = "(Required) The action to perform when the rule is matched. Possible values are Allow, Block, Log, or Redirect."<br/>    enabled                        = "(Optional) Is the rule is enabled or disabled? Defaults to true."<br/>    priority                       = "(Optional) The priority of the rule. Rules with a lower value will be evaluated before rules with a higher value. Defaults to 1."<br/>    rate_limit_duration_in_minutes = "(Optional) The rate limit duration in minutes. Defaults to 1."<br/>    rate_limit_threshold           = "(Optional) The rate limit threshold. Defaults to 10."<br/>    match_condition = (Optional) list(object({<br/>      match_variable     = "(Required) The request variable to compare with. Possible values are Cookies, PostArgs, QueryString, RemoteAddr, RequestBody, RequestHeader, RequestMethod, RequestUri, or SocketAddr."<br/>      match_values       = "(Required) Up to 600 possible values to match. Limit is in total across all match_condition blocks and match_values arguments. String value itself can be up to 256 characters in length."<br/>      operator           = "(Required) Comparison type to use for matching with the variable value. Possible values are Any, BeginsWith, Contains, EndsWith, Equal, GeoMatch, GreaterThan, GreaterThanOrEqual, IPMatch, LessThan, LessThanOrEqual or RegEx."<br/>      selector           = "(Optional) Match against a specific key if the match_variable is QueryString, PostArgs, RequestHeader or Cookies."<br/>      negation_condition = "(Optional) Should the result of the condition be negated."<br/>      transforms         = "(Optional) Up to 5 transforms to apply. Possible values are Lowercase, RemoveNulls, Trim, Uppercase, URLDecode or URLEncode."<br/>    }))<br/>  })) | <pre>object({<br/>    action                         = string<br/>    priority                       = number<br/>    rate_limit_duration_in_minutes = optional(number)<br/>    rate_limit_threshold           = optional(number)<br/>    match_condition = optional(list(object({<br/>      match_variable     = string<br/>      match_values       = list(string)<br/>      operator           = string<br/>      selector           = string<br/>      negation_condition = bool<br/>      transforms         = list(string)<br/>    })))<br/>  })</pre> | <pre>{<br/>  "action": "Block",<br/>  "match_condition": [<br/>    {<br/>      "match_values": [<br/>        "windows"<br/>      ],<br/>      "match_variable": "RequestHeader",<br/>      "negation_condition": false,<br/>      "operator": "Contains",<br/>      "selector": "UserAgent",<br/>      "transforms": null<br/>    }<br/>  ],<br/>  "priority": 10,<br/>  "rate_limit_duration_in_minutes": 1,<br/>  "rate_limit_threshold": 2000<br/>}</pre> | no |
| <a name="input_default_ruleset_exclusions"></a> [default_ruleset_exclusions](#input_default_ruleset_exclusions) | map(object({<br/>  rule_group_name = "(Required) The managed rule group to override."<br/>  rules = map(object({<br/>    rule_id = "(Required) Identifier for the managed rule."<br/>    action  = "(Optional) The action to be applied when the managed rule matches or when the anomaly score is 5 or greater. Possible values for DRS 1.1 and below are Allow, Log, Block, and Redirect. For DRS 2.0 and above the possible values are Log or AnomalyScoring. Defaults to AnomalyScoring."<br/>    exclusions = optional(map(object({<br/>      match_variable = "(Required) The variable type to be excluded. Possible values are QueryStringArgNames, RequestBodyPostArgNames, RequestCookieNames, RequestHeaderNames, RequestBodyJsonArgNames."<br/>      operator       = "(Required) Comparison operator to apply to the selector when specifying which elements in the collection this exclusion applies to. Possible values are: Equals, Contains, StartsWith, EndsWith, EqualsAny. RequestBodyJsonArgNames is only available on Default Rule Set (DRS) 2.0 or later"<br/>      selector       = "(Required) Selector for the value in the match_variable attribute this exclusion applies to. Selector must be set to * if operator is set to EqualsAny."<br/>    })), {})<br/>  }))<br/>})) | <pre>map(object({<br/>    rule_group_name = string<br/>    rules = map(object({<br/>      rule_id = string<br/>      action  = optional(string, "AnomalyScoring")<br/>      exclusions = optional(map(object({<br/>        match_variable = string<br/>        operator       = string<br/>        selector       = string<br/>      })), {})<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input_environment) | (Required) The environment where the resource is deployed. Given as abbreviation to leave more characters to the other naming components (max 3 chars). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input_instance) | (Optional) Instance number, if context includes/requires multiple resources of the same type (max 3 int). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input_location) | (Required) Location of the resource group. | `string` | n/a | yes |
| <a name="input_managed_rules"></a> [managed_rules](#input_managed_rules) | (Optional) map(object({<br/>  type    = "(Required) The name of the managed rule to use with this resource. Possible values include DefaultRuleSet, Microsoft_DefaultRuleSet, BotProtection or Microsoft_BotManagerRuleSet."<br/>  version = "(Required) The version of the managed rule to use with this resource. Possible values depends on which DRS type you are using, for the DefaultRuleSet type the possible values include 1.0 or preview-0.1. For Microsoft_DefaultRuleSet the possible values include 1.1, 2.0 or 2.1. For BotProtection the value must be preview-0.1 and for Microsoft_BotManagerRuleSet the value must be 1.0."<br/>  action  = "(Required) The action to perform for all DRS rules when the managed rule is matched or when the anomaly score is 5 or greater depending on which version of the DRS you are using. Possible values include Allow, Log, Block, and Redirect."<br/>  override = (Optional) map(object({<br/>    rule_group_name = "(Required) The managed rule group to override."<br/>  }))<br/>  rule = (Optional) map(object({<br/>    rule_id   = "(Required) Identifier for the managed rule."<br/>    action    = "(Required) The action to be applied when the managed rule matches or when the anomaly score is 5 or greater. Possible values for DRS 1.1 and below are Allow, Log, Block, and Redirect. For DRS 2.0 and above the possible values are Log or AnomalyScoring."<br/>    enabled   = "(Optional) Is the managed rule override enabled or disabled. Defaults to false"<br/>  }))<br/>})) | <pre>map(object({<br/>    type    = string<br/>    version = string<br/>    action  = string<br/>    override = map(object({<br/>      rule_group_name = string<br/>    }))<br/>    rule = map(object({<br/>      rule_id = string<br/>      action  = string<br/>      enabled = bool<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_org_id"></a> [org_id](#input_org_id) | (Required) Three letter code representing organization/tenant/CSP. | `string` | n/a | yes |
| <a name="input_redirect_url"></a> [redirect_url](#input_redirect_url) | (Optional) If action type is redirect, this field represents redirect URL for the client. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | (Required) Name of the Resource Group in which to create the resource. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | (Required) The sku's pricing tier for this Front Door Firewall Policy. Possible values include Standard_AzureFrontDoor or Premium_AzureFrontDoor | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | (Optional) Tags to be set on each resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The ID of the CDN frontdoor firewall policy. |
| <a name="output_name"></a> [name](#output_name) | The name of the CDN frontdoor firewall policy. |
| <a name="output_resource"></a> [resource](#output_resource) | The Cdn Frontdoor Firewall Policy resource. |
<!-- END_TF_DOCS -->
