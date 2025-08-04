#
###################################################################################################
# Script Name: main_windows.tf
# Description: This is the main.tf for the Windows Virtual Machine that is used by Operators. Operators will need to manually configure and install Mandiant's Commando.
# Author: Athanasius of Alexandria
# Copyright (C) 2025
#
# Version: 1.0.0
# Last Updated: 2025-08-01
# Version History
#
# This is the "main_windows.tf," which identifies the variables that are used throughout the infrastructure build. Things that need to be changed from a deployment-by-deployment basis.
####################################################################################################

# Windows VMs: Commando1 and Commando2
resource "azurerm_windows_virtual_machine" "commando1_vm" {
  name                = "${var.prefix}-Commando1"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.username
  admin_password      = var.windows_admin_password
  network_interface_ids = [azurerm_network_interface.commando1_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = 128
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-pro"
    version   = "latest"
  }

  connection {
    type     = "winrm"
    host     = azurerm_public_ip.commando1_public_ip.ip_address
    user     = var.username
    password = var.windows_admin_password
    https    = false
    insecure = true
  }
}

resource "azurerm_windows_virtual_machine" "commando2_vm" {
  name                = "${var.prefix}-Commando2"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.username
  admin_password      = var.windows_admin_password
  network_interface_ids = [azurerm_network_interface.commando2_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = 128
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-pro"
    version   = "latest"
  }

  connection {
    type     = "winrm"
    host     = azurerm_public_ip.commando2_public_ip.ip_address
    user     = var.username
    password = var.windows_admin_password
    https    = false
    insecure = true
  }
}

# Network Security Group for Windows VMs

resource "azurerm_network_security_group" "windows_nsg" {
  name                = "${var.prefix}-windows-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow_RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*" # Need to update with Public IP address of Operators.
    source_port_range          = "*"
    destination_port_range     = "3389"
    destination_address_prefix = "*"
  }
}

# NSG Associations

resource "azurerm_network_interface_security_group_association" "commando1_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.commando1_nic.id
  network_security_group_id = azurerm_network_security_group.windows_nsg.id
}

resource "azurerm_network_interface_security_group_association" "commando2_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.commando2_nic.id
  network_security_group_id = azurerm_network_security_group.windows_nsg.id
}
