#!/bin/bash

set -euo pipefail

#############################################################################
# Base Utilities Installation Script
#############################################################################

readonly JAVA_CRYPTO_CONFIG="/etc/crypto-policies/back-ends/java.config"

install_base_packages() {
    echo "==> Installing base packages..."
    yum-config-manager --disable datadog 2>/dev/null || true
    yum update -y
    yum install curl wget -y
    yum install unzip -y
    yum install -y tar
    yum install dos2unix -y
    yum install -y perl
    yum install -y python27
    yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
    yum install -y python3.12
    echo "Base packages installed successfully."
}

configure_java_symlink() {
    echo "==> Configuring Java symlink..."

    echo "Java version verified: $(java -version 2>&1 | head -1)"

    # Create legacy compatibility pathg
    mkdir -p /usr/java/latest/bin
    ln -sf /usr/bin/java /usr/java/latest/bin/java
    echo "Created legacy path: /usr/java/latest/bin/java"

    echo "Java configured successfully."
}

configure_java_crypto_policies() {
    echo "==> Configuring Java crypto policies..."

    [ -f "$JAVA_CRYPTO_CONFIG" ] || {
        echo "ERROR: Java crypto config not found"
        exit 1
    }
    # Relax crypto policies for legacy app compatibility
    sed -i 's/SHA[0-9]*,*//g; s/,SHA[0-9]*//g; s/RSA keySize < [0-9][0-9]*/RSA keySize < 1024/g' "$JAVA_CRYPTO_CONFIG"
    
    echo "Java crypto policies configured."
}

configure_python_symlink() {
    echo "==> Configuring Python 2 symlink..."
    ln -sf /usr/bin/python2.7 /usr/bin/python

    echo "Python 2 configured successfully."
}

configure_python3_for_azure_cli() {
    echo "==> Configuring Python3 for Azure CLI..."

    # Register Python 3.12 if not already registered (idempotent)
    alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 100 &>/dev/null || true
    
    # Set Python 3.12 as active version
    alternatives --set python3 /usr/bin/python3.12

    echo "Python3 version: $(python3 --version)"
    echo "Python3 configured successfully for Azure CLI."
}

install_azure_cli() {
    echo "==> Installing Azure CLI..."

    if command -v az &> /dev/null; then
        echo "Azure CLI already installed."
        return 0
    fi

    # Install Azure CLI via YUM from Microsoft repository
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    yum install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
    yum install -y azure-cli

    echo "Azure CLI installed successfully."
}


configure_ssh() {
    echo "==> Configuring SSH..."

    sed -i '/^AllowGroups ssm-user packer-user qualysvm/s/^/#/' /etc/ssh/sshd_config
    sed -i 's/^PasswordAuthentication[[:space:]]*no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    systemctl restart sshd

    echo "SSH configured successfully."
}

disable_firewall() {
    echo "==> Disabling firewall..."

    if systemctl is-active --quiet firewalld; then
        systemctl stop firewalld
    else
        echo "firewalld is already stopped."
    fi

    if systemctl is-enabled --quiet firewalld; then
        systemctl disable firewalld
    else
        echo "firewalld is already disabled."
    fi

    echo "Firewall disabled."
}

display_verification_summary() {
    echo ""
    echo "==> Verification Summary:"
    echo "Java: $(java -version 2>&1 | head -1)"
    echo "Python: $(python --version 2>&1)"
    echo "Python3: $(python3 --version 2>&1)"
    if command -v az &> /dev/null; then
        echo "Azure CLI: $(az --version 2>&1 | head -1)"
    else
        echo "Azure CLI: NOT INSTALLED"
    fi
}

#############################################################################
# MAIN
#############################################################################
main() {
    echo "=============================================="
    echo "Starting Base Utilities Installation"
    echo "=============================================="

    install_base_packages
    configure_java_symlink
    configure_java_crypto_policies
    configure_python3_for_azure_cli
    install_azure_cli
    configure_ssh
    configure_python_symlink
    disable_firewall

    echo "=============================================="
    echo "Installation Completed Successfully"
    echo "=============================================="

    display_verification_summary
}

main