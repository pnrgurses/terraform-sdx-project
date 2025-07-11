variable "azurerm_resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Location for the Azure Resource Group"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for the virtual network"
  type        = string
}
variable "vnet_name" {
  description = "Name of the Resource Group for the Virtual Network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "network_security_group_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "allowed_ports" {
  description = "List of allowed ports for the Network Security Group"
  type        = list(number)
}

variable "public_ip_name" {
  description = "Name of the Public IP"
  type        = string
}

variable "type" {
  description = "Type of the Public IP (e.g., 'Static' or 'Dynamic')"
  type        = string
}

variable "nic_name" {
  description = "Name of the Network Interface"
  type        = string
}

variable "linux_vm_name" {
  description = "Name of the Linux Virtual Machine"
  type        = string
}

variable "size" {
  description = "Size of the Linux Virtual Machine (e.g., 'Standard_B1s')"
  type        = string
}

variable "operating_system" {
  description = "Operating System for the Linux Virtual Machine (e.g., 'Ubuntu')"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the Linux Virtual Machine"
  type        = string
}

variable "authentication_type" {
  description = "Authentication type for the Linux Virtual Machine (e.g., 'password' or 'ssh')"
  type        = string
}




