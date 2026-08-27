# Switch to ingres user and run all SSH and Azure operations in a single session
su - ingres -c "
# Ensure ~/.ssh directory exists
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Generate SSH key pair only if it does not exist
if [ ! -f ~/.ssh/id_rsa ] || [ ! -f ~/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N '' -q
fi

# Copy VMs public key 
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Change permissions
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub

# Login to Azure using managed identity
az login --identity

# Upload public key to Azure Key Vault
az keyvault secret set --vault-name $key_vault_name --name ssh-pub-$computer_name-ingres --file /home/ingres/.ssh/id_rsa.pub

# Upload private key to Azure Key Vault
az keyvault secret set --vault-name $key_vault_name --name ssh-pvt-$computer_name-ingres --file /home/ingres/.ssh/id_rsa
"