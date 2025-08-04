###################################################################################################
# Script Name: network.tf
# Description: This is the network.tf for the TeamServer that is used for Cobaltstrike 
# Author: Athanasius of Alexandria
# Copyright (C) 2025
#
# Version: 1.0.0
# Last Updated: 2025-08-01
# Version History
#
# This is the "network.tf," which identifies the VNEts that are used within this operation.
####################################################################################################

resource "azurerm_virtual_network" "main" {
  count = var.create_vnet ? 1 : 0
  name = "${var.prefix}-vnet"
  address_space = ["10.0.0.0/16"]
  location = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "main" {
    count = var.create_vnet ? 1 : 0
    name = "${var.prefix}-subnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.main[0].name
    address_prefixes = ["10.0.1.0/24"]
}

data "azurerm_virtual_network" "existing" {
    count = var.create_vnet ? 0 : 1
    name = "${var.prefix}-vnet"
    resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing" {
    count = var.create_vnet ? 0 : 1
    name = "${var.prefix}-subnet"
    virtual_network_name = data.azurerm_virtual_network.existing
    resource_group_name = var.resource_group_name
}
