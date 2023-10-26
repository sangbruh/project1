#!/bin/bash
# Git error
export MSYS_NO_PATHCONV=1

# Install jq
sudo apt install jq

# Get subscription ID and make a variable
AZ_ACCOUNT_SHOW_JSON=$(az account show -o json)
SUBSCRIPTION_ID=$(echo $AZ_ACCOUNT_SHOW_JSON | jq -r '.id')

# Create IAM Service Principal
SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --name netflix-clone --role Contributor --scopes /subscriptions/$SUBSCRIPTION_ID -o json) ||

# Make and export variables
SERVICE_PRINCIPAL_TENANTID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.tenant')
SERVICE_PRINCIPAL_APPID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')

echo $SUBSCRIPTION_ID
echo $SERVICE_PRINCIPAL_TENANTID
echo $SERVICE_PRINCIPAL_APPID
echo $SERVICE_PRINCIPAL_SECRET

export ARM_SUBSCRIPTION_ID="$SUBSCRIPTION_ID"
export ARM_TENANT_ID="$SERVICE_PRINCIPAL_TENANTID"
export ARM_CLIENT_ID="$SERVICE_PRINCIPAL_APPID"
export ARM_CLIENT_SECRET="$SERVICE_PRINCIPAL_SECRET"
