#!/usr/bin/env bash

# ========= PRE-REQUISITES =========
# This script assumes:
# 1. You have installed the Azure CLI (`az` command).
# 2. You are already logged in with `az login`.
# ==================================


# ========= CONFIG =========
RESOURCE_GROUP_NAME="rg-tfstate"
STORAGE_ACCOUNT_NAME="tfstate$RANDOM"
CONTAINER_NAME="tfstate"
LOCATION="westeurope"
SP_NAME="opentofu-sp-dev-contributor"
# ==========================

echo "Getting current subscription..."
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)

echo "Creating resource group..."
az group create \
  --name $RESOURCE_GROUP_NAME \
  --location $LOCATION

echo "Creating storage account..."
az storage account create \
  --name $STORAGE_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --location $LOCATION \
  --sku Standard_LRS \
  --encryption-services blob

echo "Getting storage account key..."
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group $RESOURCE_GROUP_NAME \
  --account-name $STORAGE_ACCOUNT_NAME \
  --query '[0].value' -o tsv)

echo "Creating blob container..."
az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT_NAME \
  --account-key $ACCOUNT_KEY

echo "Creating Service Principal without password (for OIDC federation)..."
az ad sp create-for-rbac \
  --name "$SP_NAME" \
  --role Contributor \
  --scopes "//subscriptions/$SUBSCRIPTION_ID"

APP_ID=$(az ad sp list --display-name $SP_NAME --query '[0].appId' -o tsv)

echo "Done!"
echo ""
echo "Service Principal created:"
echo "  appId                    = $APP_ID"
echo "  servicePrincipalName     = $SP_NAME"
echo "  tenantId                 = $TENANT_ID"
echo ""
echo "Next step: Go to the App Registration in Azure Portal and add a Federated Credential for your GitHub repo."
echo ""
echo "Terraform backend config:"
echo "resource_group_name  = \"$RESOURCE_GROUP_NAME\""
echo "storage_account_name = \"$STORAGE_ACCOUNT_NAME\""
echo "container_name       = \"$CONTAINER_NAME\""
echo "key                  = \"dev.terraform.tfstate\""
