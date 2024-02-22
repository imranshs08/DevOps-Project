#output : output.tf

output "vm-public-ip" {
  value = try(azurerm_linux_virtual_machine.vm-server.public_ip_address)
}