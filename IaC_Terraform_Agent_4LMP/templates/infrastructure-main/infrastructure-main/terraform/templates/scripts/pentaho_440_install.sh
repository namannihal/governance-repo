#!/bin/bash
set -euo pipefail
source ./common.sh

BAMS_URL="https://bams-aws.refinitiv.com/artifactory/default.generic.global/datacloud"

# Create folders
mkdir -p /data/adcdata
mkdir -p /data/adcdata/logs
mkdir -p /data/adcdata/inputs
chown -R ingres:ingres /data/adcdata

# Copy pdi-ce-4.4.0-stable and adcingestion.sh
mkdir -p /opt/pdi-ce-4.4.0-stable
chmod 755 /opt/pdi-ce-4.4.0-stable

# Download env scripts (always refresh these)
download_with_auth "$BAMS_URL/ingestion/env/$script_env/adcingestion.sh" "/etc/profile.d" "$username" "$password"
download_with_auth "$BAMS_URL/ingestion/env/$script_env/ing-secrets.sh" "/etc/profile.d" "$username" "$password"

chmod 644 /etc/profile.d/adcingestion.sh
chmod 644 /etc/profile.d/ing-secrets.sh
source /etc/profile.d/adcingestion.sh
source /etc/profile.d/ing-secrets.sh

# Download and extract Pentaho
download_with_auth "$BAMS_URL/pdi/pdi-ce-4.4.0-stable.zip" "/opt/pdi-ce-4.4.0-stable" "$username" "$password"
unzip -o /opt/pdi-ce-4.4.0-stable/pdi-ce-4.4.0-stable.zip -d /opt/pdi-ce-4.4.0-stable
rm -f /opt/pdi-ce-4.4.0-stable/pdi-ce-4.4.0-stable.zip