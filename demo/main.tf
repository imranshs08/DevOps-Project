#Provider Section : providers.tf 

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.92.0"
    }
  }
}

provider "azurerm" {
  features {}
}

#Varaibles Setion : variables.tf

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
#Terraform TFVars : terraform.tfvars

# resource_group = "rg-1"
# location = "East US"
# virtual_network = "vnet-imran"
# subnet = "sub-imran"

# main.tf 

resource "azurerm_resource_group" "rg-name" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_public_ip" "vm-ip" {
    depends_on = [ azurerm_resource_group.rg-name ]
  name                = "vm-public-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic-vb" {
  name                = "vm-nic"
  location            = azurerm_resource_group.rg-name.location
  resource_group_name = azurerm_resource_group.rg-name.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm-ip.id
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-name.location
  resource_group_name = azurerm_resource_group.rg-name.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet
  resource_group_name  = azurerm_resource_group.rg-name.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "example" {
  depends_on          = [azurerm_resource_group.rg-name]
  name                = "example-nsg"
  location            = azurerm_resource_group.rg-name.location
  resource_group_name = azurerm_resource_group.rg-name.name
}

resource "azurerm_network_security_rule" "allowed-ports" {
  count                       = length(var.allowed_ports)
  name                        = "allowed-port-${var.allowed_ports[count.index]}"
  priority                    = 1000 + count.index
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = var.allowed_ports[count.index]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-name.name
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.nic-vb.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_linux_virtual_machine" "vm-server" {
  name                = "vm-server"
  resource_group_name = azurerm_resource_group.rg-name.name
  location            = azurerm_resource_group.rg-name.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic-vb.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = self.public_ip_address
      user = "adminuser"
      private_key = file("~/.ssh/id_rsa")
    }
  inline = [ 
    "sudo apt update",
    "sudo apt install python3-pip -y",
    "sudo apt install screen -y",
    "pip3 install Flask",
    "wget https://raw.githubusercontent.com/imranshs08/DevOps-Project/master/Python/simple-python-app/app.py",
    "echo '#!/bin/bash' > start_flask.sh",
    "echo 'python3 app.py &' >> start_flask.sh",
    "sudo chmod +x start_flask.sh",
    "screen -d -m ./start_flask.sh" 
   ]
  }
}


#output : output.tf

output "vm-public-ip" {
  value = azurerm_linux_virtual_machine.vm-server.public_ip_address
}

