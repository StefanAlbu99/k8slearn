terraform {
  cloud {
    organization = "k8slearning"
    workspaces {
      name = "k8slearning"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "westeurope"
}

resource "azurerm_storage_account" "storage" {
  name                     = "examplestorageacc99x"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
