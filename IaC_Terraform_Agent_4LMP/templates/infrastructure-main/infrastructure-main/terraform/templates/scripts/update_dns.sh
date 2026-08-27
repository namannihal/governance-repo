# Assign argument to variable
super_private_dns_environment="$1"

# Remove /etc/NetworkManager/conf.d/90-dns-none.conf if it exists
if [ -f /etc/NetworkManager/conf.d/90-dns-none.conf ]; then
    echo "/etc/NetworkManager/conf.d/90-dns-none.conf exists. Removing it."
    rm -f /etc/NetworkManager/conf.d/90-dns-none.conf
fi

# Check if DNS domain already exists in /etc/resolv.conf
dns_domain="datacloud-$super_private_dns_environment.4.superprivate.azure.private.inf0.net"
if grep -q "$dns_domain" /etc/resolv.conf; then
    echo "DNS domain $dns_domain already exists in /etc/resolv.conf. Exiting script."
    exit 0
fi

#unlock resolv.conf
chattr -i /etc/resolv.conf

# Get Active Connections
connection=$(nmcli -t -f NAME connection show --active | head -n 1)
echo "configuration dns for connection: $connection"

# Extract all nameservers
default_dns=$(grep '^nameserver' /etc/resolv.conf | head -n 1 | awk '{print $2}')

# Extract search domain
default_search=$(grep '^search' /etc/resolv.conf | awk '{$1=""; print $0}' | xargs)

# Append additional search domain
additional_search="datacloud-$super_private_dns_environment.4.superprivate.azure.private.inf0.net"
combined_search="$default_search $additional_search"

# Apply DNS Settings
nmcli connection modify "$connection" ipv4.dns "$default_dns"
nmcli connection modify "$connection" ipv4.dns-search "$combined_search"
nmcli connection modify "$connection" ipv4.ignore-auto-dns yes

# Restart NetworkManager to apply settings
systemctl restart NetworkManager

# Wait for NetworkManager to finish writing resolv.conf before locking
for i in $(seq 1 15); do
    sleep 2
    grep -q "$additional_search" /etc/resolv.conf && break
    echo "Waiting for NetworkManager to settle... ($i/15)"
done

if ! grep -q "$additional_search" /etc/resolv.conf; then
    echo "ERROR: superprivate domain not found in /etc/resolv.conf after 30s. Aborting without locking."
    cat /etc/resolv.conf
    exit 1
fi

# Lock resolv.conf to prevent DNS reset on reboot
chattr +i /etc/resolv.conf

# Display final DNS configuration
cat /etc/resolv.conf