variable "resource_group" {
  default = "rg-1"
}
variable "location" {
  default = "East US"
}
variable "virtual_network" {
  default = "vnet-imran"
}
variable "subnet" {
  default = "sub-imran"
}

variable "allowed_ports" {
  default = ["80", "22", "5000", "8080"]
}