#!/bin/bash

# Assign key vault name from first argument
key_vault_name="$1"

INGRES_SECRET_NAME="ingestion-ingres-password"
ADCADMIN_SECRET_NAME="ingestion-adcadmin-password"
# Define users and groups
USER_INGRES="ingres"
USER_ADCADMIN="adcadmin"
GROUP_INGRES="ingres"
GROUP_ADCADMIN="adcadmin"

# Fetch password for ingres from Key Vault
az login --identity

INGRES_PASSWORD=$(az keyvault secret show \
    --vault-name "$key_vault_name" \
    --name "$INGRES_SECRET_NAME" \
    --query value -o tsv 2>/dev/null)

ADCADMIN_PASSWORD=$(az keyvault secret show \
    --vault-name "$key_vault_name" \
    --name "$ADCADMIN_SECRET_NAME" \
    --query value -o tsv 2>/dev/null)

if [[ -z "$INGRES_PASSWORD" ]]; then
    echo "Failed to fetch password for $USER_INGRES from Key Vault: $key_vault_name / $INGRES_SECRET_NAME"
    exit 1
fi

if [[ -z "$ADCADMIN_PASSWORD" ]]; then
    echo "Failed to fetch password for $USER_ADCADMIN from Key Vault: $key_vault_name / $ADCADMIN_SECRET_NAME"
    exit 1
fi

# Function to create a group if it doesn't exist
create_group() {
    local group_name=$1
    if ! getent group "$group_name" >/dev/null; then
        echo "Creating group: $group_name"
        groupadd "$group_name"
    else
        echo "Group $group_name already exists."
    fi
}

# Function to create a user if it doesn't exist
create_user() {
    local user_name=$1
    local primary_group=$2
    local additional_groups=$3
    local sudoer=$4
    local password=$5

    if ! id "$user_name" &>/dev/null; then
        echo "Creating user: $user_name"
        useradd -m -g "$primary_group" -G "$additional_groups" -s /bin/bash "$user_name"

        # Set password from Key Vault
        echo "$user_name:$password" | chpasswd
        echo "Password set for $user_name from Key Vault."
    else
        echo "User $user_name already exists."
        echo "$user_name:$password" | chpasswd
    fi

    # If user should be a sudoer, configure permissions
    if [[ "$sudoer" == "yes" ]]; then
        echo "$user_name ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/"$user_name" > /dev/null
        chmod 440 /etc/sudoers.d/"$user_name"
        echo "User $user_name added to sudoers with NOPASSWD."
    fi
}

# Create groups
create_group "$GROUP_INGRES"
create_group "$GROUP_ADCADMIN"

# Create users and assign them to the correct groups
create_user "$USER_INGRES" "$GROUP_INGRES" "$GROUP_INGRES,$GROUP_ADCADMIN" "no" "$INGRES_PASSWORD"
create_user "$USER_ADCADMIN" "$GROUP_ADCADMIN" "$GROUP_ADCADMIN" "yes" "$ADCADMIN_PASSWORD"

echo "User and group setup completed."