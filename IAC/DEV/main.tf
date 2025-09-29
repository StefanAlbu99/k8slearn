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

module "aks" {
  source = "../modules/aks"

  org            = "stef"
  env            = "dev"
  location_short = "weu"
  location       = "West Europe"
  node_count     = 2
  vm_size        = "Standard_DS3_v2"
  tags = {
    environment = "dev"
    project     = "k8s-demo"
  }
}

