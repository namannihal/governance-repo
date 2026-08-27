locals {
  # App Gateway can upload certificates into AKV when use_keyvault_certificates=true,
  # or consume inline certificate data in direct mode when false.
  cert_password          = trimspace(var.cert_password)
  cert_password_provided = nonsensitive(trimspace(var.cert_password)) != ""

  raw_appgw_certificates = {
    "couchdb-cert"          = var.couchdb_cert
    "qdct_cert"             = var.qdct_cert
    "qdct-cert"             = var.qdct_cert
    "hvpweb_cert"           = var.hvpweb_cert
    "hvpweb-cert"           = var.hvpweb_cert
    "guidancebre_cert"      = var.guidancebre_cert
    "guidancebre-cert"      = var.guidancebre_cert
    "estimatessdi_cert"     = var.estimatessdi_cert
    "estimatessdi-cert"     = var.estimatessdi_cert
    "estimatesbre_cert"     = var.estimatesbre_cert
    "estimatesbre-cert"     = var.estimatesbre_cert
    "brokerxl_cert"         = var.brokerxl_cert
    "brokerxl-cert"         = var.brokerxl_cert
    "broker_cert"           = var.broker_cert
    "broker-cert"           = var.broker_cert
    "guidance_cert"         = var.guidance_cert
    "guidance-cert"         = var.guidance_cert
    "collection_cert"       = var.collection_cert
    "collection-cert"       = var.collection_cert
    "actualsbre_cert"       = var.actualsbre_cert
    "actualsbre-cert"       = var.actualsbre_cert
    "qdct-cert-dev"         = var.qdct_dev_cert
    "hvpweb-cert-dev"       = var.hvpweb_dev_cert
    "guidancebre-cert-dev"  = var.guidancebre_dev_cert
    "estimatessdi-cert-dev" = var.estimatessdi_dev_cert
    "estimatesbre-cert-dev" = var.estimatesbre_dev_cert
    "brokerxl-cert-dev"     = var.brokerxl_dev_cert
    "broker-cert-dev"       = var.broker_dev_cert
    "guidance-cert-dev"     = var.guidance_dev_cert
    "collection-cert-dev"   = var.collection_dev_cert
    "actualsbre-cert-dev"   = var.actualsbre_dev_cert
    "qdct-cert-qa"          = var.qdct_qa_cert
    "hvpweb-cert-qa"        = var.hvpweb_qa_cert
    "guidancebre-cert-qa"   = var.guidancebre_qa_cert
    "estimatessdi-cert-qa"  = var.estimatessdi_qa_cert
    "estimatesbre-cert-qa"  = var.estimatesbre_qa_cert
    "brokerxl-cert-qa"      = var.brokerxl_qa_cert
    "broker-cert-qa"        = var.broker_qa_cert
    "guidance-cert-qa"      = var.guidance_qa_cert
    "collection-cert-qa"    = var.collection_qa_cert
    "actualsbre-cert-qa"    = var.actualsbre_qa_cert
  }

  appgw_certificate_payloads = {
    for name, value in local.raw_appgw_certificates : name => value
  }

  appgw_certificate_presence = {
    for name, value in local.raw_appgw_certificates : name => nonsensitive(value) != ""
  }

  key_vault_certificate_secrets_to_upload = var.use_keyvault_certificates ? {
    for cert in var.ssl_certificates : cert.name => {
      name         = cert.name
      value        = lookup(local.appgw_certificate_payloads, cert.name, "")
      content_type = "application/x-pkcs12"
    }
    if lookup(local.appgw_certificate_presence, cert.name, false)
  } : {}

  key_vault_password_secret_to_upload = var.use_keyvault_certificates && local.cert_password_provided ? {
    "certificate-password" = {
      name         = "certificate-password"
      value        = local.cert_password
      content_type = "text/plain"
    }
  } : {}

  key_vault_secrets_to_upload = merge(local.key_vault_certificate_secrets_to_upload, local.key_vault_password_secret_to_upload)

  key_vault_secret_names = {
    for name, secret in local.key_vault_secrets_to_upload : name => secret.name
  }

  ssl_certificate_inline_data = {
    for cert in var.ssl_certificates : cert.name => (
      try(cert.data, null) == null ? null : (
        trimspace(cert.data) == "" ? null : (
          trimspace(cert.data)
        )
      )
    )
  }

  ssl_certificate_path_data = {
    for cert in var.ssl_certificates : cert.name => (
      try(cert.path_of_certificate, null) == null ? null : (
        can(file(cert.path_of_certificate)) ? (
          trimspace(file(cert.path_of_certificate)) == "" ? null : (
            trimspace(file(cert.path_of_certificate))
          )
        ) : filebase64(cert.path_of_certificate)
      )
    )
  }

  ssl_certificates_final = [
    for cert in var.ssl_certificates : {
      name = cert.name
      key_vault_secret_id = var.use_keyvault_certificates ? (
        lookup(local.appgw_certificate_presence, cert.name, false) ? azurerm_key_vault_secret.application_gateway_secrets[cert.name].versionless_id : try(cert.key_vault_secret_id, null)
      ) : null
      data = var.use_keyvault_certificates ? null : (
        local.ssl_certificate_inline_data[cert.name] != null ? local.ssl_certificate_inline_data[cert.name] : (
          lookup(local.appgw_certificate_presence, cert.name, false) ? lookup(local.appgw_certificate_payloads, cert.name, "") : (
            local.ssl_certificate_path_data[cert.name]
          )
        )
      )
      password = var.use_keyvault_certificates ? null : (
        try(cert.password, null) != null ? cert.password : (
          try(cert.data, null) != null || lookup(local.appgw_certificate_presence, cert.name, false) || try(cert.path_of_certificate, null) != null ? (local.cert_password_provided ? local.cert_password : null) : null
        )
      )
    }
  ]

  ssl_certificate_input_diagnostics = {
    cert_password_provided    = local.cert_password_provided
    use_keyvault_certificates = var.use_keyvault_certificates
    certificates = {
      for cert in var.ssl_certificates : cert.name => {
        tf_var_from_previous_stage = lookup(local.appgw_certificate_presence, cert.name, false)
        inline_data_present        = try(cert.data, null) != null
        path_present               = try(cert.path_of_certificate, null) != null
        payload_encoding           = "base64_pfx"
        akv_upload_enabled         = var.use_keyvault_certificates && lookup(local.appgw_certificate_presence, cert.name, false)
        effective_source = var.use_keyvault_certificates ? (
          lookup(local.appgw_certificate_presence, cert.name, false) ? "tf_var_to_akv_secret" : (
            try(cert.key_vault_secret_id, null) != null ? "existing_key_vault_secret_id" : "missing"
          )
          ) : (
          try(cert.data, null) != null ? "inline_data" : (
            lookup(local.appgw_certificate_presence, cert.name, false) ? (local.cert_password_provided ? "tf_var" : "missing_cert_password") : (
              try(cert.path_of_certificate, null) != null ? "path_of_certificate" : "missing"
            )
          )
        )
      }
      if contains(keys(local.raw_appgw_certificates), cert.name)
    }
  }

  # ---------------------------------------------------------------------------
  # Trusted Root Certificates — CA cert for CouchDB backend (HTTPS:6984).
  # Automatically extracted from var.couchdb_cert (PFX) by the external
  # data source above. No separate HashiCorp Vault entry required.
  # Empty list when couchdb_cert is not provided (non-CouchDB environments).
  # ---------------------------------------------------------------------------
  trusted_root_certificates_final = length(data.external.couchdb_ca_cert) > 0 ? [
    for cert in var.trusted_root_certificates : {
      name                = cert.name
      data                = data.external.couchdb_ca_cert[0].result.ca_cert_base64
      key_vault_secret_id = null
    }
  ] : []
}
