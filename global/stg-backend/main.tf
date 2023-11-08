terraform {
  backend "azurerm" {
    key = "web-cluster.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.76.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf-bck" {
  name     = "tf-bck1"
  location = "East US"
}