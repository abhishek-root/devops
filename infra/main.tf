terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "random_id" "vm_id" {
  byte_length = 2
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = "devops-vnet"
  subnet_name         = "devops-subnet"
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.network.subnet_id
  vm_name             = "devops-vm-${random_id.vm_id.hex}"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "abhi-resource"          # your resource group
    storage_account_name = "abhi905950" # your storage account
    container_name       = "terraformstate"            # container name
    key                  = "terraform.tfstate"  # state file name
  }
}

