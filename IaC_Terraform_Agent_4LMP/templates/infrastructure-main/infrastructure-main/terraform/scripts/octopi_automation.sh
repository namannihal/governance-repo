#!/bin/bash

set -euo pipefail

# Export template variables as environment variables
export username="${username}"
export password="${password}"
export extension_environment="${extension_environment}"
export script_env="${script_env}"
export computer_name="${computer_name}"
export key_vault_name="${key_vault_name}"
export super_private_dns_environment="${super_private_dns_environment}"

bams_url="https://bams-aws.refinitiv.com/artifactory/default.generic.cloud/app-51847/app/ingestion/${extension_environment}"

function download_script() {
    local bams_url="$${1}"
    local bams_user="$${2}"
    local bams_password="$${3}"
    local script_name="$${4}"

    echo "Downloading $${script_name}..."
    wget -q "$${bams_url}/$${script_name}" -O "$${script_name}" --http-user="$${bams_user}" --http-password="$${bams_password}"
}

function execute_script() {
    local bams_url="$${1}"
    local bams_user="$${2}"
    local bams_password="$${3}"
    local script_name="$${4}"

    download_script "$${bams_url}" "$${bams_user}" "$${bams_password}" "$${script_name}"

    echo "Executing $${script_name}..."
    sed -i 's/\r$$//' "./$${script_name}"
    bash "./$${script_name}" "$${@:5}"
}

download_script "$${bams_url}" "${username}" "${password}" "common.sh"
source ./common.sh

require_env "username" "password" "extension_environment" "script_env" "computer_name" "key_vault_name" "super_private_dns_environment"

execute_script "$${bams_url}" "${username}" "${password}" "base_utilities.sh"
execute_script "$${bams_url}" "${username}" "${password}" "create_user.sh" "${key_vault_name}"
execute_script "$${bams_url}" "${username}" "${password}" "mount_drive.sh"
execute_script "$${bams_url}" "${username}" "${password}" "ant_install.sh" "${username}" "${password}"
execute_script "$${bams_url}" "${username}" "${password}" "pentaho_440_install.sh" "${username}" "${password}" "${script_env}"
execute_script "$${bams_url}" "${username}" "${password}" "autossh_prereq.sh" "${username}" "${password}" "${computer_name}" "${key_vault_name}"
execute_script "$${bams_url}" "${username}" "${password}" "datadog_ingestion.sh" "${key_vault_name}"
execute_script "$${bams_url}" "${username}" "${password}" "update_dns.sh" "${super_private_dns_environment}"
execute_script "$${bams_url}" "${username}" "${password}" "copy_and_import_cert.sh" "${username}" "${password}"