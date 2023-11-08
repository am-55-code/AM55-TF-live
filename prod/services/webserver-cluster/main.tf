terraform {
    
    backend "azurerm" {
        key = "prod-vmss-cluster.tfstate"      
    }
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.76.0"
    }
  }
}
provider "azurerm" {
  skip_provider_registration = true

    features {
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    virtual_machine_scale_set {
      force_delete                  = false
      roll_instances_when_required  = true
      scale_to_zero_before_deletion = true
    }
  }
}

module "webserver-vmss" {
    source = "../../../../../04-tf-module/module-example/modules/services/webserver-cluster"
    cluster_name = "prod-cluster"
    region = "East US"
    cluster_sku = "Standard_B2ms"
    instance_count = 4
    os_disk_replication = "Standard_LRS"
    state_file_remote_key = "prod-vmss-cluster"
    storage_container_name = "prod"
   
}

