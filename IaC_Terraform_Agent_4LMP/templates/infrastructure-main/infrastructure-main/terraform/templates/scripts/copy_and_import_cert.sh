#!/bin/bash

set -euo pipefail

username=$1
password=$2

wget "https://bams-aws.refinitiv.com/artifactory/default.generic.cloud/app-51847/lseg_root_ca.cer" --http-user="${username}" --http-password="${password}"
if ! keytool -list -keystore /etc/pki/ca-trust/extracted/java/cacerts -storepass changeit -alias "LSEG Root CA" >/dev/null 2>&1; then
  keytool -importcert -trustcacerts \
    -file lseg_root_ca.cer \
    -alias "LSEG Root CA" \
    -keystore /etc/pki/ca-trust/extracted/java/cacerts \
    -storepass changeit -noprompt || { echo "keytool import failed"; exit 1; }
else
  echo "Certificate alias 'LSEG Root CA' already exists, skipping import."
fi