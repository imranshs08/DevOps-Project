
module "azure_infra" {
  source = "./azure_infra_module"

  // Pass input variables to the module
  location        = var.location-add
  resource_group  = var.resource_group-name
  virtual_network = var.virtual_network-name
  subnet          = var.subnet-name
  
}

