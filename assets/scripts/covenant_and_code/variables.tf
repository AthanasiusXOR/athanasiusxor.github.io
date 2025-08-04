#
###################################################################################################
# Script Name: variables.tf
# Description: Centralized variable definitions for Red Team Terraform deployments in Azure.  
# Author: Athanasius of Alexandria
# Copyright (C) 2025
#
# Version: 1.0.0
# Last Updated: 2025-08-01
# Version History
#
# This is the "variables.tf," which identifies the variables that are used throughout the infrastructure build. 
# Things that need to be changed from a deployment-by-deployment basis.
####################################################################################################

# Region for deployment
variable "location" {
  description = "Azure region for deployment"
  type = string
  default = "East US"
}

# Administrator User for all VMs
variable "username" {
  description = "Administrator username for Virtual Machines"
  type = string
  default = "operator" # This can be changed on a case-by-case basis. Update as the shooter see's fit.
}

# Prefix for all resource names (used for namespacing deployments)
variable "prefix" {
  description = "Prefix to use for all resource names"
  type = string
  default = "TestBed1" # This needs to be specific to your operation, use an acronym of the operation name if possible.
}

# Virtual Machine Size (Default is 2vCPUs / 8GiB RAM)
variable "vm_size" {
  description = "Azure Virtual Machine size to use"
  type = string
  default = "Standard_D4s_v5"
}

# SSH Public Keys for Linux Virtual Machine access.
variable "ssh_public_keys" {
  description = "File path for SSH public key"
  type = list(string)
  default = [
    "C:/terraform/RND/ssh/Person1.pub", 
    "C:/terraform/RND/ssh/Person2.pub", 
    "C:/terraform/RND/ssh/Person3.pub",
    "C:/terraoform/RND/ssh/Person4.pub"
    ]
}

# Resource group name (used for all modules; usually set to operation codename)
variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type = string
  default = "Research_and_Development" # The Resource Group Name should be a unique name to the current operation. 
}

# Administrator password for Windows Virtual Machines
variable "windows_admin_password" {
  description = "The admin passwrod for the Windows Virtual Machine."
  type = string
  default = "StLouisCardinals_Rule" # This can/needs to be changed per deployment. For Windows RDP-only. Highly recommend not hardcoding passwords but using Azure Key Vault for deployment.
  sensitive = true
}

# Whether to create the VNet in this module (true=create, false=reference existing)
variable "create_vnet" {
  description = "Flag to create a new virtual network in this module"
  type = bool
  default = false # This needs to be updated based on the deployment type. Is the virtual network being deployed 
}
