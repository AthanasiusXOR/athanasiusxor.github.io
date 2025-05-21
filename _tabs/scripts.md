---
title: Scripts
icon: fas fa-terminal
order: 5
---

# Red Team Infrastructure Scripts

> *"Let all things be done decently and in order." — 1 Corinthians 14:40*

Below are operational scripts and Terraform files used to automate red team infrastructure deployment through **Azure and Terraform**, hosted under `/scripts/`.

---

## Terraform Configuration Files

- [`main.tf`](/scripts/terraform/azure/main.tf)  
  Core Terraform deployment script for provisioning VMs, NICs, and linking provisioners.

- [`network.tf`](/scripts/terraform/azure/network.tf)  
  Subnet, IP address, and NIC definitions used by the VMs.

- [`variables.tf`](/scripts/terraform/azure/variables.tf)  
  Editable variables: resource group name, passwords, key paths, usernames, etc.

---

## Bash Automation Scripts

- [`kalisetup.sh`](/scripts/bash/kalisetup.sh)  
  Automates setup of Kali boxes with RDP, tools, and mounts.

- [`teamserver.sh`](/scripts/bash/teamserver.sh)  
  Sets up Cobalt Strike environment, SMB mount, and tooling.

- [`smb.sh`](/scripts/bash/smb.sh)  
  Mounts Azure File Shares onto redirector VMs.

---

> 🛡️ **Use with authorization.** These scripts are intended for lawful red team assessments only.

**AthanasiusXOR**  

**Contra Mundum. Code Obscurum.**
