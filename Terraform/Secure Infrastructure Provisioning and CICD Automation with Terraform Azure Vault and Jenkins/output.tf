#output : output.tf

output "vm-public-ip-module" {
  value = try(module.azure_infra.vm-public-ip)
}