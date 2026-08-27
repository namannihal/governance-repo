# application_gateway

Deploys the Azure Application Gateway and supports two certificate modes:

- AKV-backed certificate mode when `use_keyvault_certificates = true`
- direct inline certificate mode when `use_keyvault_certificates = false`

## What this module does

- Creates the Application Gateway, WAF policy, public IP, and managed identity.
- Grants the managed identity the Key Vault roles needed to read certificates and secrets.
- Uploads BAS-fed base64 PFX payloads into AKV as secrets before the gateway is created.
- Stores the shared `cert_password` in AKV as the `certificate-password` secret.
- Configures the gateway to read certificates from `ssl_certificates[*].key_vault_secret_id`.

## BAS inputs

This module requires `TF_VAR_cert_password` for direct inline PFX mode.

The module currently supports four certificate naming patterns in `ssl_certificates[*].name`:

- prod hyphen names such as `couchdb-cert`, `qdct-cert`, and `hvpweb-cert`
- legacy names such as `qdct_cert` and `hvpweb_cert`
- DEV-suffixed names such as `qdct-cert-dev` and `hvpweb-cert-dev`
- QA-suffixed names such as `qdct-cert-qa` and `hvpweb-cert-qa`

Each certificate payload used by this module is normalized to a Base64-encoded PFX string before use. `cert_password` is plain text.

On the LSEG runner, the BAS retrieval step can either pass a certificate payload directly through `TF_VAR_*_cert` or materialize it into `.pfx` files under `/builds/app/app-52161/infra/iac_terraform`. The module keeps already-base64 payloads as-is and uses Terraform base64 encoding for non-base64 inputs before passing `cert_password` to the Application Gateway SSL certificate block.

The per-certificate `TF_VAR_*_cert` entries in the pipeline are direct Terraform inputs for this module. If `ssl_certificates[*].data` is not set, the module prefers the matching `TF_VAR_*_cert` value before falling back to `path_of_certificate`.

Name mapping is exact and currently resolves like this:

- `couchdb-cert` -> `TF_VAR_couchdb_cert`
- `qdct_cert` -> `TF_VAR_qdct_cert`
- `qdct-cert` -> `TF_VAR_qdct_cert`
- `qdct-cert-dev` -> `TF_VAR_qdct_dev_cert`
- `qdct-cert-qa` -> `TF_VAR_qdct_qa_cert`

The same pattern applies to `hvpweb`, `guidancebre`, `estimatessdi`, `estimatesbre`, `brokerxl`, `broker`, `guidance`, `collection`, and `actualsbre`.

Example BAS wiring:

```yaml
BAS_VS_SECRET_LIST: |
  TF_VAR_cert_password@gitlab/app-52161/kv/cert/ppr-eus2@cert_password
  TF_VAR_couchdb_cert@gitlab/app-52161/kv/cert/ppr-eus2@couchdb_cert
  TF_VAR_qdct_cert@gitlab/app-52161/kv/cert/ppr-eus2@qdct_cert
  TF_VAR_hvpweb_cert@gitlab/app-52161/kv/cert/ppr-eus2@hvpweb_cert
  TF_VAR_qdct_dev_cert@gitlab/app-52161/kv/cert/dev-eus2@qdct_dev_cert
  TF_VAR_qdct_qa_cert@gitlab/app-52161/kv/cert/qa-eus2@qdct_qa_cert
```

## AKV upload behavior

When `use_keyvault_certificates = true`:

- every configured certificate whose name matches an entry in `ssl_certificates` is uploaded into AKV as an `azurerm_key_vault_secret` containing the normalized base64 PFX payload
- the shared password is stored in AKV as an `azurerm_key_vault_secret` named `certificate-password`
- the Application Gateway reads the uploaded secret using the generated `key_vault_secret_id`; if no TF_VAR payload is provided for a certificate, the module keeps the existing `ssl_certificates[*].key_vault_secret_id`

## Example tfvars

```hcl
use_keyvault_certificates = false

http_listeners = [
  {
    name                           = "lsn-priv-https-qdctweb-dev"
    frontend_ip_configuration_name = "appgateway-feip-priv"
    frontend_port_name             = "appgateway-feporthttps"
    protocol                       = "Https"
    ssl_certificate_name           = "qdct-cert-dev"
    sni_required                   = true
    listener_type                  = "MultiSite"
    host_name                      = "qdct.dev.estimates.dbors.internal"
    host_names                     = null
    firewall_policy_id             = null
  }
]

ssl_certificates = [
  {
    name                = "qdct-cert-dev"
    key_vault_secret_id = null
    path_of_certificate = "/builds/app/app-52161/infra/iac_terraform/qdct_dev_cert.pfx"
    data                = null
    password            = null
  },
  {
    name                = "qdct-cert-qa"
    key_vault_secret_id = null
    path_of_certificate = "/builds/app/app-52161/infra/iac_terraform/qdct_qa_cert.pfx"
    data                = null
    password            = null
  }
]
```

## Notes

- `http_listeners[*].ssl_certificate_name` must exactly match one entry in `ssl_certificates[*].name`.
- Use `sni_required` for HTTPS multisite listeners. `require_sni` is not part of this module's typed input schema.
- In LSEG runner mode, `path_of_certificate` can point either to a file that already contains Base64 PFX text or to a raw certificate file. Terraform keeps valid Base64 as-is and uses `filebase64(...)` or `base64encode(...)` when encoding is needed.
- In AKV mode, the module does not try to decode the PFX payload inside Terraform. It uploads the Base64 PFX string as a Key Vault secret because that is what Application Gateway can consume through `key_vault_secret_id`.
- This module expects direct-mode certificates to come from `data` or `path_of_certificate` in `ssl_certificates`.
- In AKV mode, if no matching `TF_VAR_*_cert` payload is supplied for a certificate, the module keeps the `ssl_certificates[*].key_vault_secret_id` already provided in tfvars.
- The `certificate-password` secret is uploaded only when `cert_password` is non-empty.