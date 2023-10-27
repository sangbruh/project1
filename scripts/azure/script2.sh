#!/bin/bash
# Git error
export MSYS_NO_PATHCONV=1

# Login
az login

# App name
appName="netflix-clone"

# Get Ids from az account
subscriptionId=$(az account show --query id --output tsv)
tenantId=$(az account show --query tenantId --output tsv)

# Create IAM Service Principal
servicePrincipal=$(az ad sp create-for-rbac --name $appName --role Contributor --scopes /subscriptions/$subscriptionId -o json)

# Make and export variables
#SERVICE_PRINCIPAL_TENANTID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.tenant')
#SERVICE_PRINCIPAL_APPID=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
#SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')

echo $subscriptionId
#echo $SERVICE_PRINCIPAL_TENANTID
#echo $SERVICE_PRINCIPAL_APPID
#echo $SERVICE_PRINCIPAL_SECRET

#export ARM_SUBSCRIPTION_ID="$SUBSCRIPTION_ID"
#export ARM_TENANT_ID="$SERVICE_PRINCIPAL_TENANTID"
#export ARM_CLIENT_ID="$SERVICE_PRINCIPAL_APPID"
#export ARM_CLIENT_SECRET="$SERVICE_PRINCIPAL_SECRET"
