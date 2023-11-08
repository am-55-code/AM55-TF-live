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
    source = "../../../../../04-tf-module/module-example/modules/services/webserver-cluster"
    cluster_name = "staging-cluster"
    region = "East US"
    cluster_sku = "Standard_B1s"
    instance_count = "1"
    os_disk_replication = "Standard_LRS"
    state_file_remote_key = "staging-vmss-cluster"
    storage_container_name = "tfstate"
}

resource "azurerm_lb_rule" "allow_ssh_port" {
loadbalancer_id = module.webserver-vmss
name = "SSH Inbound"
protocol = "tcp"
frontend_port = 22
backend_port = 22
frontend_ip_configuration_name = "staging-cluster-ssh-inbound"

}

