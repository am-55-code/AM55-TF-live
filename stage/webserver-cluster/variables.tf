variable "cluster_name" {
  description = "Name for the cluster"
  type = string
  default = "staging-vmss-cluster"

}

variable "region" {
  description = "Region for cluster"
  type = string
  default = "East US"
  
}

variable "cluster_sku" {
  description = "SKU Family for the cluster"
  type = string
  default = "Standard_B1s"
}

variable "os_disk_replication" {
  description = "Replication for the OS disk"
  type = string
  default = "Standard_LRS"
}


variable "stg_container_name" {
    description = "Name for storage container"
    type = string
    default = "tfstate"
  
}
