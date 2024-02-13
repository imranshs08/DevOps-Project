resource "azurerm_resource_group" "rg-tf" {
  name     = "rg-azure"
  location = "East US"
}

resource "azurerm_virtual_network" "vm-tf" {
  name                = "vm-azure"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
}

resource "azurerm_subnet" "subnet-tf" {
  name                 = "subnet-tf"
  resource_group_name  = azurerm_resource_group.rg-tf.name
  virtual_network_name = azurerm_virtual_network.vm-tf.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "tf-nic"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-tf.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "tf-vm" {
  name                = "tf-machine"
  resource_group_name = azurerm_resource_group.rg-tf.name
  location            = azurerm_resource_group.rg-tf.location
  size                = "Standard_F2"
  admin_username      = "imran"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "imran"
    public_key = file("C:\\Users\\imran\\OneDrive - Jamia Millia Islamia (A Central University)\\Desktop\\2024\\Terraform\\azure vm\\ssh-keys\terraform-azure.pub")
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
}