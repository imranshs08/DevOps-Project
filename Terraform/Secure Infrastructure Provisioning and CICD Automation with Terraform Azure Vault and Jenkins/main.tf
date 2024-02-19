provider "azurerm" {
  features {}
}

variable "location" {}
variable "resource_group" {}
variable "virtual_network" {}
variable "subnet" {}

output "vm_public_ip" {
  value = azurerm_public_ip.vm.ip_address
}

module "azure_infra" {
  source = "./azure_infra_module"
  
  // Pass input variables to the module
  location          = var.location
  resource_group    = var.resource_group
  virtual_network   = var.virtual_network
  subnet            = var.subnet
}
