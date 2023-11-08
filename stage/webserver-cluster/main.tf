terraform {
    
    backend "azurerm" {
        key = "staging-cluster.tfstate"      
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
    virtual_machine_scale_set {
      force_delete                  = false
      roll_instances_when_required  = true
      scale_to_zero_before_deletion = true
    }
  }
}

module "webserver-vmss" {

    source = "github.com/am-55-code/TF-modules/services/webserver-cluster"
    
    cluster_name = "staging-cluster"
    region = var.region

    cluster_sku = var.cluster_sku
    instance_count = "1"

    os_disk_replication = var.os_disk_replication
    state_file_remote_key = var.remote_key
    storage_container_name = var.stg_container_name
}