#
###################################################################################################
# Script Name: main_teamserver.tf
# Description: This is the main.tf for the TeamServer that is used for Cobaltstrike. 
# Author: Athanasius of Alexandria
# Copyright (C) 2025
#
# Version: 1.0.0
# Last Updated: 2025-08-01
# Version History
#
# This is the "main_teamserver.tf," which identifies the variables that are used throughout the infrastructure build. Things that need to be changed from a deployment-by-deployment basis.
####################################################################################################

# Specify required Terraform version and Azure Provider
terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~>3.0" # Adjust this to match the specific version of Hashicorp needs. 
      }
    }
    required_version = ">= 1.9" # Require TerraForm Version is 1.9 and above. This can be changed if needed.
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources =  false # This is a deletion protection. But do not trust it. The "terraform delete/destroy" command will delete ALL in the resource_group_name.
    }
  }
}

resource "azurerm_resource_group" "main" {
    name = var.resource_group_name
    location = var.location
}

# TeamServer of Public IP Address
resource "azurerm_public_ip" "teamserver_public_ip" {
    name = "${var.prefix}-teamserver-pip"
    location = var.location
    resource_group_name = var.resource_group_name
    allocation_method = "Static"
    sku = "Basic"
}

# Network Interface for TeamServer
resource "azurerm_network_interface" "teamserver_nic" {
  name = "${var.prefix}-teamserver-nic"
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = "internal"
    subnet_id = var.create_vnet ? azurerm_subnet.main[0].id : data.azurerm_subnet.existing[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.teamserver_public_ip
  }
}

# Network Security Group for the TeamServer
resource "azurerm_network_security_group" "teamserver_nsg" {
  name = "${var.prefix}-teamserver-nsg"
  location = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name = "Allow_Inbound_SSH_Teamserver"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "10.0.1.0/24"
    source_port_range = "*"
    destination_port_range = "22"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "Allow_Inbound_HTTP_AFD"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "AzureFrontDoor.Backend"
    source_port_range = "*"
    destination_port_range = "80"
    destination_address_prefix = "*"
  }

    security_rule {
    name = "Allow_Inbound_HTTPS_AFD"
    priority = 102
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "AzureFrontDoor.Backend"
    source_port_range = "*"
    destination_port_range = "443"
    destination_address_prefix = "*"
  }
}

# Network Security Group Association with Network Interface Card
resource "azurerm_network_interface_security_group_association" "teamserver_nic_nsg" {
  network_interface_id = azurerm_network_interface.teamserver_nic.id
  network_security_group_id = azurerm_network_security_group.teamserver_nsg.id
}

# TeamServer Virtual Machine.
resource "azurerm_linux_virtual_machine" "teamserver_vm" {
    name = "${var.prefix}-teamserver"
    resource_group_name = var.resource_group_name
    location = var.location
    size = var.vm_size
    admin_username = var.username
    network_interface_ids = [azurerm_network_interface.teamserver_nic.id]

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
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
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "18_04-lts-gen2"
      version = "latest"
    }

    provisioner "file" {
        source = "./teamserver.sh"
        destination = "/home/${var.username}/teamserver.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo chmod +x /home/${var.username}/teamserver.sh",
            "sudo bash /home/${var.username}/teamserver.sh",
            "exit 0"
        ]
    }

    connection {
        type = "ssh"
        host = azurerm_public_ip.teamserver_public_ip.ip_address
        user = var.username
        private_key = file("path/to/private/key") # This will need to be updated to point to Private Key for SSH authentication.
    }
}

