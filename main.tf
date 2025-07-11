
provider "azurerm" {
  features {}
  subscription_id = "<your_subscription_id_here>"
}

resource "azurerm_resource_group" "sdx-rg" {
  name     = var.azurerm_resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "sdx-vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.sdx-rg.location
  resource_group_name = azurerm_resource_group.sdx-rg.name
}

resource "azurerm_subnet" "sdx-subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.sdx-rg.name
  virtual_network_name = azurerm_virtual_network.sdx-vnet.name
  address_prefixes     = [var.subnet_cidr]
}


resource "azurerm_network_security_group" "sdx-nsg" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.sdx-rg.location
  resource_group_name = azurerm_resource_group.sdx-rg.name
}

resource "azurerm_network_security_rule" "dynamic_ports" {
  for_each = { for port in var.allowed_ports : tostring(port) => port }

  name                        = "Allow-Port-${each.key}"
  priority                    = 100 + each.value
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.sdx-rg.name
  network_security_group_name = azurerm_network_security_group.sdx-nsg.name
}

resource "azurerm_public_ip" "sdx-pip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.sdx-rg.location
  resource_group_name = azurerm_resource_group.sdx-rg.name
  allocation_method   = var.type
}

resource "azurerm_network_interface" "sdx-nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.sdx-rg.location
  resource_group_name = azurerm_resource_group.sdx-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sdx-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.sdx-pip.id
  }
}

resource "azurerm_linux_virtual_machine" "sdx-vm" {
  name                  = var.linux_vm_name
  location              = azurerm_resource_group.sdx-rg.location
  resource_group_name   = azurerm_resource_group.sdx-rg.name
  network_interface_ids = [azurerm_network_interface.sdx-nic.id]
  size                  = var.size
  admin_username        = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("C:/Users/pinar.gurses/.ssh/id_ed25519.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "osdisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(<<EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    systemctl start apache2
    systemctl enable apache2
    echo "<h1>Apache server that made with Terraform</h1>" > /var/www/html/index.html
    EOF
    )
}

resource "azurerm_subnet_network_security_group_association" "sdx-subnet-nsg" {
  subnet_id                 = azurerm_subnet.sdx-subnet.id
  network_security_group_id = azurerm_network_security_group.sdx-nsg.id
}






