#!/usr/bin/env bash
# extract-ca-cert.sh
# Called by Terraform external data source.
# Reads a base64-encoded PFX from stdin (JSON), extracts the root CA certificate,
# and returns it as a base64-encoded DER on stdout (JSON).
#
# Input JSON:  { "pfx_base64": "<b64>", "pfx_password": "<password>" }
# Output JSON: { "ca_cert_base64": "<b64 DER>" }
#
# Dependencies: bash, jq, openssl (all standard on Linux GitLab runners)

set -euo pipefail

# Parse inputs
eval "$(jq -r '@sh "PFX_B64=\(.pfx_base64) PFX_PASS=\(.pfx_password)"')"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

PFX_FILE="$TMPDIR/couchdb.pfx"
CA_PEM="$TMPDIR/couchdb-ca.pem"

# Write PFX to temp file
printf '%s' "$PFX_B64" | base64 -d > "$PFX_FILE"

# Extract CA / chain certs only (no private key, no server cert)
# -cacerts flag returns only non-leaf CA certificates from the chain
openssl pkcs12 -in "$PFX_FILE" \
  -cacerts -nokeys \
  -out "$CA_PEM" \
  -passin "pass:$PFX_PASS" 2>/dev/null

# If -cacerts returned nothing (self-signed / single-cert PFX), fall back
# to extracting the cert itself (it is both server cert and CA)
if [ ! -s "$CA_PEM" ]; then
  openssl pkcs12 -in "$PFX_FILE" \
    -clcerts -nokeys \
    -out "$CA_PEM" \
    -passin "pass:$PFX_PASS" 2>/dev/null
fi

# base64-encode the PEM (single line, no wrapping)
CA_B64=$(base64 -w 0 "$CA_PEM")

jq -n --arg ca "$CA_B64" '{"ca_cert_base64": $ca}'
