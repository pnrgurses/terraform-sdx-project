output "vm_public_ip" {
  description = "Public IP address of the Linux Virtual Machine"
  value       = azurerm_public_ip.sdx-pip.ip_address
}


