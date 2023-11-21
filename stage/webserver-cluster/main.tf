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
  }
}

module "keyvault" {
  source = "git@github.com:am-55-code/TF-modules.git//services/key-vault?ref=v0.6"
  
}

module "webserver-vmss" {
  source = "git@github.com:am-55-code/TF-modules.git//services/webserver-cluster?ref=v0.3"

  cluster_name   = "staging-cluster"
  cluster_sku    = "Standard_B1s"
  instance_count = "1"
  region         = "East US"
  custom_tags = {
    Owner = "dev-team"
    ManagedBy = "TF"
  }


  os_disk_replication    = "Standard_LRS"
  storage_container_name = "tfstate"
  state_file_remote_key  = "staging-vmss-cluster.tfstate"

}

