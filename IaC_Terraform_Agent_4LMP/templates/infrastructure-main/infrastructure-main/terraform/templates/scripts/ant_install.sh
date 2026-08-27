#!/bin/bash
set -euo pipefail
source ./common.sh

ts "Starting Apache Ant installation"

# Download Apache Ant using common.sh helper
download_with_auth "https://bams-aws.refinitiv.com/artifactory/default.generic.global/datacloud/ant/apache-ant-1.8.4.zip" "/home/ingres" "$username" "$password"

# Unzip Apache Ant
ts "Extracting Apache Ant..."
unzip -o /home/ingres/apache-ant-1.8.4.zip -d /opt
chmod +x /opt/apache-ant-1.8.4/bin/ant

# Download ant-setup.sh
download_with_auth "https://bams-aws.refinitiv.com/artifactory/default.generic.global/datacloud/ant/ant-setup.sh" "/etc/profile.d" "$username" "$password"

# Set permissions
ts "Setting permissions"
chmod 644 /etc/profile.d/ant-setup.sh
chmod -R go+X /opt/apache-ant-1.8.4/
chmod -R go+r /opt/apache-ant-1.8.4/

# Cleanup
ts "Cleaning up temporary files..."
rm -f /home/ingres/apache-ant-1.8.4.zip

ok "Apache Ant installation completed successfully."