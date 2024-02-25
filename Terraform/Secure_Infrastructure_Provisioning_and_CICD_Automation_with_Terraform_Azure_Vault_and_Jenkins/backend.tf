terraform {
  backend "azurerm" {
    resource_group_name = "feb18"
    storage_account_name = "storageaccountim12"
    container_name = "tfstate"
    key = "prod.terraform.tfstate"
  }
}