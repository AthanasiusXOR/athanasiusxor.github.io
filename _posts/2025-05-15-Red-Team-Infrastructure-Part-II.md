---
title: "Azure Terraform Infrastructure (Part II): Execution and Deployment"
date: 2025-05-15
categories: [red-team, infrastructure, azure, terraform]
tags: [terraform, deployment, automation, red team, cloud]
---

> *“Commit your work to the LORD, and your plans will be established.” — Proverbs 16:3*

---

> ⚠️ **Use With Integrity**  
All techniques shown are for authorized environments only.  
We pursue **righteous intrusion** — not reckless exploitation.  
> *“Abstain from every form of evil.” — 1 Thessalonians 5:22*

---

## I. Introduction: From Blueprint to Build

This is **Part II** of our Azure Infrastructure series. If **[Part I](https://nicenesecurity.com/posts/Red-Team-Infrastructure-Part-I/)** laid the theological and tactical groundwork, **Part II** is where we bring it to life. As a reminder, below is a rudimentary outline of the network that we will deploy with Terraform.

![Azure Red Team Infrastructure](assets/img/Azure-Infrastructure/Azure-Network-Diagram.png)

We move now from **philosophy to execution** — walking step-by-step through the files and scripts that build FAST infrastructure from scratch. Red teamers don’t just *know* how things work. We build them. We break them. And we build again.

> *"By wisdom a house is built, and by understanding it is established." — Proverbs 24:3*

---

## II. Terraform Files Breakdown

### 📄 `main.tf`

Defines core providers and virtual machines to be deployed. This file controls **what** Azure spins up.

**Key Elements:**
- Resource declarations for Kali, Windows, GoPhish, etc.
- VM size, location, disk image
- Depends on variables defined in `variables.tf`

**What You Must Edit:**
- Ensure public key paths, VM names, and images align with your operation
- Add/modify `depends_on` logic if customizing interdependent resources

> [Click the link](https://github.com/AthanasiusXOR/athanasiusxor.github.io/blob/main/scripts/terraform/azure/main.tf) below to unveil what was hidden-for as with Scripture, so with strategy, so with strategy: the form and function are revealed not in abstraction, but in faithful exposition.

---

### 📄 `network.tf`

Defines your virtual network, subnet ranges, and public IPs.

**Key Elements:**
- VNet and Subnet CIDRs
- NSG (Network Security Group) rules
- Public/Private IP allocations

**What You Must Edit:**
- Validate address ranges (e.g., `10.0.1.0/24`) do not conflict with client environments
- Review and tighten NSG rules

> [Click the link](https://github.com/AthanasiusXOR/NiceneSecurity/blob/main/Scripts/Terraform/Azure/Build%20One/network.tf) below to unveil what was hidden-for as with Scripture, so with strategy, so with strategy: the form and function are revealed not in abstraction, but in faithful exposition.

---

### 📄 `variables.tf`

Declares all configurable inputs — passwords, SSH keys, and resource group names.

```
hcl
variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "King_of_Kings"
}

variable "windows_admin_password" {
  description = "Password for Windows RDP"
  type        = string
  sensitive   = true
  default     = "Jesus_Is_Lord"
}

variable "ssh_public_keys" {
  description = "List of public SSH keys"
  type        = list(string)
  default     = ["./Athanasius.pub"]
}
```


## What You Must Edit (from `variables.tf`)

- **Operation-specific naming** in `resource_group_name`
- A **strong Windows password** in `windows_admin_password`
- Add all relevant **`.pub` keys from operators** to `ssh_public_keys`


> [Click the link](https://github.com/AthanasiusXOR/NiceneSecurity/blob/main/Scripts/Terraform/Azure/Build%20One/variables.tf) below to unveil what was hidden-for as with Scripture, so with strategy, so with strategy: the form and function are revealed not in abstraction, but in faithful exposition.

---

## III. Scripted Provisioning: Bash Automation

These `.sh` scripts run on first boot to configure VMs into fully operational red team platforms.

---

### 🔧 `kalisetup.sh`

Used for **Kali0, Kali1, and Kali2**. This script:

- Installs 40+ offensive tools (Metasploit, C2 profiles, Impacket, etc.)
- Configures XRDP for GUI access
- Sets RDP password for `azureuser`
- Mounts Azure SMB file shares
- Installs reflective loaders, Malleable C2 profiles, and custom Cobalt Strike tools

**What You Must Edit:**

- Replace `INSERT PASSWORD` for `azureuser`
- Replace **SMB credentials** (`username`, `password`)
- Confirm **file share mount path** if changed

---

### 🔧 `teamserver.sh`

Used for the **TeamServer VM**. This script:

- Updates the system and installs key red team tools
- Mounts Azure SMB file shares (same credentials as above)
- Copies and extracts `cobaltstrike-dist-linux.tgz` from the mounted share
- Preps server for C2 operation

**What You Must Edit:**

- SMB credentials
- Confirm `cobaltstrike-dist-linux.tgz` exists in `/mnt/infrastructure-setup/`

> [Click here](https://github.com/AthanasiusXOR/NiceneSecurity/tree/main/Scripts/Bash) to uncover the work done in silence — for as the Word became flesh to dwell among us, so these bash scripts embody intention in action, revealing not just what we build, but how we labor in truth.

---

## IV. Deployment Workflow

Once your `.tf` files and bash scripts are configured, follow this deployment process:

### Authenticate to Azure

```
az login  
az account set --subscription "<Your Subscription ID>"
```

![AZ Login](assets/img/Azure-Infrastructure/AZ-Login.jpg)

![AZ Login II](assets/img/Azure-Infrastructure/AZ-Login-II.jpg)

### Deploy Infrastructure

```
terraform init  
terraform plan -out=tfplan  
terraform apply tfplan
```

Wait for all VMs to spin up — initial provisioning may take 5–10 minutes.  
Confirm Azure Front Door and DNS manually (see next section).

---

## V. Azure Front Door & DNS Configuration

> “He will be the sure foundation for your times, a rich store of salvation and wisdom and knowledge.” — Isaiah 33:6

The Front Door of any fortress matters. This section will cover:

- Custom domain setup (e.g., Namecheap)
- TLS/SSL chaining
- Routing paths to redirectors
- WAF configuration for evasion-friendly passthrough

📌 *Coming soon — this section will be updated with screenshots, scripts, and real deployment guidance from live operations.*

---

## VI. Operational Checklist

- ✅ VMs deployed successfully?  
- ✅ Bash scripts executed fully?  
- ✅ CobaltStrike extracted and functional?  
- ✅ Redirectors live?  
- ✅ Azure Front Door configured and pointed to domain?

### Tear Down When Complete

```
terraform destroy -auto-approve
```

> “Every house is built by someone, but the builder of all things is God.” — Hebrews 3:4

---

## References

- [Terraform Documentation – HashiCorp](https://developer.hashicorp.com/terraform/docs)  
- [Azure Front Door – Microsoft](https://azure.microsoft.com/en-us/products/frontdoor)  
- [Automating Red Team Infrastructure with Terraform – Red Canary](https://redcanary.com/blog/automating-red-team-infrastructure-with-terraform/)  
