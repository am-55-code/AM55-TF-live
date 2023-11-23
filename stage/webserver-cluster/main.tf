terraform {

  backend "azurerm" {
    key                  = "staging-vmss-cluster.tfstate"
    container_name       = "tfstate"
    storage_account_name = "tfstg055654770390"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.80.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.46.0"
    }
  }
}
provider "azurerm" {
  skip_provider_registration = true

  features {
    virtual_machine_scale_set {
      force_delete                  = false
      roll_instances_when_required  = true
      scale_to_zero_before_deletion = true
    }
      
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

locals {
  #cluster_name = "staging-cluster"
  service-principal = "Terraform-SP-Staging"
}

module "keyvault" {
  source = "git@github.com:am-55-code/TF-modules.git//services/key-vault?ref=v0.6.4"

  cluster_name = var.cluster_name
}

module "webserver-vmss" {
  source = "git@github.com:am-55-code/TF-modules.git//services/webserver-cluster?ref=v0.6.9"

  cluster_name   = var.cluster_name
  cluster_sku    = "Standard_B1s"
  instance_count = "1"
  region         = "East US"
  username       = "am55"
  os_disk_replication = "Standard_LRS"
   custom_tags = {
    Owner     = "dev-team"
    ManagedBy = "TF"
  }
}

