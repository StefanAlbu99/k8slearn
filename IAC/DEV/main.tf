terraform {
  required_version = ">= 1.6.0"
  backend "azurerm" {
    # resource_group_name  = "rg-tfstate-management"
    # storage_account_name = "tfstatedev5362"
    # container_name       = "dev-tfstate"
    # key                  = "dev.terraform.tfstate"
    # use_oidc             = true
    # subscription_id      = "00000000-0000-0000-0000-000000000000"
    # tenant_id            = "00000000-0000-0000-0000-000000000000"

    #instead lets using the terraform init -backend-config=backend.dev.tfvars
    }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Generate a random suffix
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "test-rg-${random_string.suffix.result}"
  location = "westeurope"
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
