#
###################################################################################################
# Script Name: main_kali.tf
# Description: This is the main.tf for the Kali Linux Virtual Machines that is used by Operators. 
# Author: Athanasius of Alexandria
# Copyright (C) 2025
#
# Version: 1.0.0
# Last Updated: 2025-08-01
# Version History
#
# This is the "main_kali.tf," which identifies the variables that are used throughout the infrastructure build. Things that need to be changed from a deployment-by-deployment basis.
####################################################################################################

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  required_version = ">= 1.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name = var.resource_group_name
  location = var.location
}


resource "azurerm_public_ip" "kali0_public_ip" {
  name = "${var.prefix}-kali0-pip"
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  sku = "Basic"
}

resource "azurerm_network_interface" "kali0_nic" {
  name = "${var.prefix}-kali0-nic"
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = "internal"
    subnet_id = var.create_vnet ? azurerm_subnet.main[0].id : data.azurerm_subnet.existing[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.kali0_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "kali0_vm" {
  name = "${var.prefix}-kali0"
  resource_group_name = var.resource_group_name
  location = var.location
  size = var.vm_size
  admin_username = var.username
  network_interface_ids = [azurerm_network_interface.kali0_nic.id]

  plan {
    name = "kali-2024-2"
    product = "kali"
    publisher = "kali-linux"
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = 128
  }

  admin_ssh_key {
    username = var.username
    public_key = file(var.ssh_public_keys[0])
  }

  source_image_reference {
    publisher = "kali-linux"
    offer = "kali"
    sku = "kali-2024-2"
    version = "latest"
  }

  provisioner "file" {
    source = "./kalisetup.sh"
    destination = "/home/${var.username}/kalisetup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/${var.username}/kalisetup.sh",
      "sudo rm /home/${var.username}/kalisetup.sh",
      "sudo systemctl start xrdp",
      "sudo systemctl start ssh",
      "exit 0"
    ]
  }

  connection {
    type = "ssh"
    host = azurerm_public_ip.kali0_public_ip.ip_address
    user = var.username
    private_key = file("path/to/private/key") # This needs to be updated with private key from "authorized" user.
  }
}

resource "azurerm_public_ip" "kali1_public_ip" {
  name = "${var.prefix}-kali1-pip"
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  sku = "Basic"
}

resource "azurerm_network_interface" "kali1_nic" {
  name = "${var.prefix}-kali1-nic"
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = "internal"
    subnet_id = var.create_vnet ? azurerm_subnet.main[0].id : data.azurerm_subnet.existing[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.kali1_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "kali1_vm" {
  name = "${var.prefix}-kali1"
  resource_group_name = var.resource_group_name
  location = var.location
  size = var.vm_size
  admin_username = var.username
  network_interface_ids = [azurerm_network_interface.kali1_nic.id]

  plan {
    name = "kali-2024-2"
    product = "kali"
    publisher = "kali-linux"
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = 128
  }

  admin_ssh_key {
    username = var.username
    public_key = file(var.ssh_public_keys[0])
  }

  source_image_reference {
    publisher = "kali-linux"
    offer = "kali"
    sku = "kali-2024-2"
    version = "latest"
  }

  provisioner "file" {
    source = "./kalisetup.sh"
    destination = "/home/${var.username}/kalisetup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/${var.username}/kalisetup.sh",
      "sudo rm /home/${var.username}/kalisetup.sh",
      "sudo systemctl start xrdp",
      "sudo systemctl start ssh",
      "exit 0"
    ]
  }

  connection {
    type = "ssh"
    host = azurerm_public_ip.kali1_public_ip.ip_address
    user = var.username
    private_key = file("path/to/private/key") # This needs to be updated with private key from "authorized" user.
  }
}

resource "azurerm_public_ip" "kali2_public_ip" {
  name = "${var.prefix}-kali2-pip"
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  sku = "Basic"
}

resource "azurerm_network_interface" "kali2_nic" {
  name = "${var.prefix}-kali2-nic"
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = "internal"
    subnet_id = var.create_vnet ? azurerm_subnet.main[0].id : data.azurerm_subnet.existing[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.kali2_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "kali2_vm" {
  name = "${var.prefix}-kali2"
  resource_group_name = var.resource_group_name
  location = var.location
  size = var.vm_size
  admin_username = var.username
  network_interface_ids = [azurerm_network_interface.kali2_nic.id]

  plan {
    name      = "kali-2024-2"
    product   = "kali"
    publisher = "kali-linux"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 128
  }

  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_public_keys[0])
  }

  source_image_reference {
    publisher = "kali-linux"
    offer     = "kali"
    sku       = "kali-2024-2"
    version   = "latest"
  }

  provisioner "file" {
    source      = "./kalisetup.sh"
    destination = "/home/${var.username}/kalisetup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/${var.username}/kalisetup.sh",
      "sudo rm /home/${var.username}/kalisetup.sh",
      "sudo systemctl start xrdp",
      "sudo systemctl start ssh",
      "exit 0"
    ]
  }

  connection {
    type        = "ssh"
    host        = azurerm_public_ip.kali2_public_ip.ip_address
    user        = var.username
    private_key = file("path/to/private/key") # This needs to be updated with private key from "authorized" user.
  }
}

resource "azurerm_public_ip" "kali3_public_ip" {
  name = "${var.prefix}-kali3-pip"
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  sku = "Basic"
}

resource "azurerm_network_interface" "kali3_nic" {
  name = "${var.prefix}-kali3-nic"
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = "internal"
    subnet_id = var.create_vnet ? azurerm_subnet.main[0].id : data.azurerm_subnet.existing[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.kali3_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "kali3_vm" {
  name = "${var.prefix}-kali3"
  resource_group_name = var.resource_group_name
  location = var.location
  size = var.vm_size
  admin_username = var.username
  network_interface_ids = [azurerm_network_interface.kali3_nic.id]

  plan {
    name      = "kali-2024-2"
    product   = "kali"
    publisher = "kali-linux"
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = 128
  }

  admin_ssh_key {
    username = var.username
    public_key = file(var.ssh_public_keys[0])
  }

  source_image_reference {
    publisher = "kali-linux"
    offer = "kali"
    sku = "kali-2024-2"
    version = "latest"
  }

  provisioner "file" {
    source = "./kalisetup.sh"
    destination = "/home/${var.username}/kalisetup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/${var.username}/kalisetup.sh",
      "sudo rm /home/${var.username}/kalisetup.sh",
      "sudo systemctl start xrdp",
      "sudo systemctl start ssh",
      "exit 0"
    ]
  }

  connection {
    type = "ssh"
    host = azurerm_public_ip.kali3_public_ip.ip_address
    user = var.username
    private_key = file("path/to/private/key") # This needs to be updated with private key from "authorized" user.
  }
}

# Network Security Group for Kali Linux Machines

resource "azurerm_network_security_group" "kali_nsg" {
  name = "${var.prefix}-kali-nsg"
  location = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name = "Allow_Inbound_SSH"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*" # Update with the Public IP Address of Operators.
    source_port_range = "*"
    destination_port_range = "22"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "Allow_Inbound_RDP"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*" # Update with the Public IP Address of Operators.
    source_port_range = "*"
    destination_port_range = "3389"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "Allow_Inbound_Cobaltstrike"
    priority = 102
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = azurerm_network_interface.teamserver_nic.private_ip_address # This can be changed to just the Private IP Address of the TeamServer once fully deployed. 
    source_port_range = "*"
    destination_port_range = "50050"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "kali0_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.kali0_nic.id
  network_security_group_id = azurerm_network_security_group.kali_nsg.id
}

resource "azurerm_network_interface_security_group_association" "kali1_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.kali1_nic.id
  network_security_group_id = azurerm_network_security_group.kali_nsg.id
}

resource "azurerm_network_interface_security_group_association" "kali2_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.kali2_nic.id
  network_security_group_id = azurerm_network_security_group.kali_nsg.id
}

resource "azurerm_network_interface_security_group_association" "kali3_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.kali3_nic.id
  network_security_group_id = azurerm_network_security_group.kali_nsg.id
}
