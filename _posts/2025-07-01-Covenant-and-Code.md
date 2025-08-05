---
title: Covenant and Code - Building Lawful Infrastructure with Terraform
date: 2025-09-01
tags: [red-team, doctrine, creation, lab, infrastructure]
---
>
> ⚠️ The infrastructure, code, and methodologies described in this blog are designed **solely for lawful, educational, and ethical purposes**. This series is intended to help red team professionals, security researchers, and students build controlled environments for testing, training, and strengthening defensive postures.
>
> As those made in the image of God and called to walk in integrity, we affirm that knowledge must be governed by wisdom. The Apostle Paul reminds us, _“All things are lawful, but not all things are helpful”_ (1 Cor. 10:23). Accordingly, these tools are not to be used for harm, unauthorized access, or malicious activity of any kind.
>
> Let it be clear: **this work is to be conducted with a clear conscience before both God and man** (Acts 24:16). Those who weaponize such knowledge outside the bounds of legality and virtue not only violate human law, but grieve the moral law of the Creator Himself.
>
> _“Whatever you do, in word or deed, do everything in the name of the Lord Jesus...”_
>
> — **Colossians 3:17**

---

> "*Now therefore, if you will indeed obey my voice and keep my covenant, you shall be my treasured possession among all peoples...*"
>
> — **Exodus 19:5**

### Theological Framing: Sinai and Structure

![The Covenant](https://www.nicenesecurity.com/assets/img/Covenant_and_Code/the-israelites-passing-through-the-wilderness-preceded-by-the-pillar-of-light-william-west.jpg)

At Sinai, God did not merely hands down rules — He established a **covenant**. The Mosaic covenant was a **Suzerain-Vassal treaty**, where the sovereign (God) laid out the terms of relationship, worship, obedience, and identity for His people (Israel). This wasn’t Israel’s first exposure to divine commands, but the **formalization** of a covenant that had been progressively unfolding since **Adam**, **Noah**, and **Abraham**.

In **Genesis**, we see God's covenant rhythm: He forms (creation), promises (Adamic/Noahic), and then structures (Abrahamic → Mosaic). By **Exodus 19–24**, God declares Israel as His “treasured possession,” gives the **Ten Words** (Decalogue), and outlines a repeatable, covenantal system. Laws are codified. Worship is structured. The community is secured by divine command, not by improvisation.

This movement from chaos to covenant — from **garden to nation**, from **promise to law** — is the same movement we make when we take raw infrastructure (IP space, compute, networks, secrets) and impose **modular Terraform design** on it. In red team infrastructure, ad-hoc deployments might function temporarily, but covenantal thinking demands:

- **Reusability** (as in the covenant’s generational continuity)  
- **Declarative clarity** (as in the Ten Words)  
- **Accountability and inheritance** (as in covenant blessings/curses)  
- **Defined structure and scope** (as in tabernacle design or land inheritance)

Just as God wrote the covenant terms **in stone**, you write your infrastructure terms in `.tf` files: variables, inputs, outputs, module blocks. Each is a **declaration of order** over chaos — a binding design that others on your team can trace, repeat, and inherit.

The Mosaic covenant also includes **blessings and curses** (Deut 28). In Terraform, the “curse” of improper dependency or misconfigured state is real — you risk drift, exposure, or broken deployments. But when modularized properly, your infrastructure is governed by a clear hierarchy, where each module knows its **authority, inheritance, and output**.

In Azure, for red team operations, this might mean:

- A **network module** that establishes all address space, NSGs, and routing (your “land boundaries”)  
- A **compute module** that defines operator workstations and C2 boxes (your “military force”)  
- A **secrets module** that stores credentials and tokens (your “priesthood access”)  
- A **monitoring/bastion module** that acts like the tabernacle — central, secure, and separated  

All modules should adhere to a **higher law** — a main root configuration (`main.tf`) that acts as the “book of the covenant,” uniting them in purpose and execution.

This is what Sinai teaches: God's people don't just live — they live under covenant. And for red team infrastructure to be secure, repeatable, and trustworthy, it must also be governed not by intuition or tribal memory, but by **codified covenantal structure**.


---
### 1. Modular Terraform: Law by Design

In red team infrastructure — especially when operating in cloud environments like Azure — clarity, repeatability, and control are essential. Terraform modules help enforce these through **structured, reusable patterns** that reflect the same **design-by-decree** approach we see at Sinai.


![Terraform_Slates](https://www.nicenesecurity.com/assets/img/Covenant_and_Code/terraform.png)

---

#### **Why Modules Matter**

Much like the Mosaic Law established boundaries, roles, and responsibilities for the people of God, **Terraform modules create clarity and order** within your infrastructure. They ensure:

- **Reusability**: Avoid repeating code. Define once, reuse across environments.
- **Clarity**: Modules make your infrastructure easier to understand and audit.
- **Encapsulation**: Each component is responsible for itself. Inputs and outputs are defined like covenant obligations — clear terms, no assumptions.
- **Inheritance and traceability**: You can version modules, pass variables, and track output — much like the generational application of the covenant.

---

#### **Suggested Modules for Red Team Infrastructure**

Just as the Law covered every area of life — diet, worship, justice — your infrastructure modules should cover each key domain:

- **Virtual Machines**: `modules/linux_vm/`, `modules/windows_vm/`
- **Virtual Networks (VNets)**: `modules/network/`
- **Network Security Groups (NSGs)**: `modules/nsgs/`
- **Subnets**: `modules/subnet/`
- **Common Tagging Policies**: `modules/tags/`

These modules act like the priests, Levites, and leaders in Israel — each with a **defined function**, all working in harmony under the root configuration.

---

#### 📁 **Codebase Example**

```
/modules/
linux_vm/
main.tf
variables.tf
outputs.tf

/envs/dev/
main.tf
terraform.tfvars

/envs/prod/
main.tf
terraform.tfvars
```

Your `/modules/` directory contains the **universal law** — codified, versioned, and testable. The `/envs/` directories are the **application of that law** to specific contexts (like how different tribes implemented the same covenant in localized ways).

---

#### **Structure Like Sinai**

At Sinai, God did not leave Israel to improvise worship or security. Every detail — from the **Ark of the Covenant** to the **dimensions of the tabernacle curtains** — was defined. Terraform modules bring this same **lawful precision** to your infrastructure:

- No deployment is rogue.
- Every resource knows its **origin**, **purpose**, and **boundaries**.
- Relationships are governed by **inputs**, **outputs**, and **dependencies**, not loose coupling.

Your modules are the **Torah** of your red team infrastructure — a law not of restriction, but of flourishing, security, and holy order in hostile terrain.

> “See that you make everything according to the pattern shown you on the mountain.”  
>
> — *Exodus 25:40*

---

### 2. State Management: The Book of the Covenant

At Sinai, God not only gave His people laws — He gave them a **record**. The *Book of the Covenant* (Exodus 24:7) was read aloud, committed to memory, and sealed with blood. It served as the authoritative reference for Israel’s identity, obligations, and obedience. In Terraform, your equivalent is the **state file**.

---

#### **Why State Management Matters**

The `terraform.tfstate` file is your **single source of truth**. It records every declared resource, dependency, and output — what exists, where, and why. Without it, your infrastructure **loses coherence**, much like Israel would lose her way without the covenant scroll.

---

#### **Use Remote Backends (Azure Example)**

To prevent state drift, corruption, or loss, store your state file in a **remote backend** like an Azure Storage Account:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "StateStorageRG"
    storage_account_name = "statebackendstore"
    container_name       = "tfstate"
    key                  = "redteam.tfstate"
  }
}
```

This ensures:

- Centralized state tracking across teams and environments
- Versioned change history, like Israel's story unfolding across generations
- Resilience against local machine loss or misconfiguration

---

### 3. Secrets Management: Holy of Holies

In the Mosaic covenant, the **Holy of Holies** was the innermost sanctuary of the tabernacle — a sacred space, hidden behind the veil, where the Ark of the Covenant rested and God's presence dwelled. Only the high priest could enter, and only once a year, with blood.

Your **secrets** — passwords, API tokens, private keys, and credentials — are your infrastructure’s sacred artifacts. They deserve the same **reverent separation** and **strict access controls**.

---

#### **Best Practices for Secret Handling**

- ❌ **Never** store secrets directly in `.tf` files or commit them to version control  
- ✅ Use the `terraform-provider-azurerm` to integrate with **Azure Key Vault**
- ✅ For local development, use **environment variables** to inject secrets securely

```hcl
resource "azurerm_key_vault_secret" "example" {
  name         = "c2-token"
  value        = var.c2_token
  key_vault_id = azurerm_key_vault.main.id
}
```

```
export TF_VAR_c2_token="super_secret_token_value"
```

Your credentials should live **behind the veil** — not in your repo, not in plaintext, and not scattered across files like **golden calves in the camp**.

---

### Theological Typology: Secrets as Sacred

Just as the high priest treated the Holy of Holies with fear and trembling, so too must we treat **secrets as holy and set apart**. Poor secret management leads not just to breaches, but to **profane deployments** — where sacred data is exposed, and access is defiled.

> “Thus shall Aaron come into the Holy Place... and he shall not die.” 
> 
> — *Leviticus 16:3*

But this section also serves as a **theological reminder**.

---

### Typology and Supremacy: Terraform Is Not the Lawgiver

Terraform’s structure is powerful. It teaches us to think **covenantally** — to design with clarity, inheritance, and security in mind. But it is a **type**, not the **substance**. It points beyond itself.

Like the Mosaic covenant, which was a **shadow of something greater** (Hebrews 8:5), Terraform patterns teach us to **order and secure**. But we must never mistake the infrastructure for the King. The Law points us to Christ — and in the same way, Terraform reminds us of the need for **holy structure**, while also teaching us to long for **redemption**, not just deployment.

> “We have such a high priest, one who is seated at the right hand of the throne of the Majesty in heaven.”  
>
> — *Hebrews 8:1*

So while we may build with excellence, let our hearts not be buried in `.tfstate` files or module outputs. Let every provisioned resource remind us of the **greater Provision**: **Jesus Christ**, our High Priest, who entered the **true Holy of Holies once for all** (Hebrews 9:12).


---

### 4. Inputs, Outputs, Variables: Covenant Conditions

In a covenant, there are always **conditions**: terms to uphold, boundaries to respect, and blessings (or curses) that follow obedience or failure. At Sinai, God declared, *“If you will indeed obey my voice and keep my covenant, you shall be my treasured possession”* (Exodus 19:5). The people were called to respond, to act in light of what had been declared.

Terraform mirrors this covenant structure through the use of **inputs** (variables), **outputs**, and **defined constraints**. These aren’t arbitrary — they’re the **conditions** by which your infrastructure is governed.

---

#### **Inputs: `variables.tf` as the Covenant Entry Point**

Your `variables.tf` file defines the **terms** of engagement — what each module requires in order to function properly. These variables act as **entry points into your infrastructure law**, making expectations clear and explicit.

```hcl
variable "location" {
  description = "The Azure region to deploy into"
  type        = string
  default     = "eastus"
}

variable "instance_count" {
  description = "Number of VMs to deploy"
  type        = number
  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 10
    error_message = "Must be between 1 and 10 instances."
  }
}
```

Just as God did not leave Israel guessing what He required, your moduels should not operate by assumption. Define the terms, apply validation, and give defaults where possible--this is the clarity of covenant in action. 

### Outputs: Blessings for Other Modules

Your `outputs.tf` file is where your module **declares its blessings** — what it offers to the rest of the infrastructure. Outputs are how child modules pass data upward or horizontally, enabling **inheritance, visibility, and modular harmony**.

```hcl
output "vm_public_ip" {
  value       = azurerm_public_ip.main.ip_address
  description = "The public IP address of the deployed VM"
}
```

Think of outputs as the **inheritance clauses of the covenant**. What you deploy in one module often shapes or empowers what another module can do — just as one generation’s obedience to the covenant shaped Israel’s future.

### Terraform Modules in Action

You can explore the actual Terraform scripts used in this project:

- [main_kali.tf](https://www.nicenesecurity.com/assets/scripts/covenant_and_code/main_kali.tf) — deploys Kali Linux red team VMs  
- [main_teamserver.tf](https://www.nicenesecurity.com/assets/scripts/covenant_and_code/main_teamserver.tf) — sets up the teamserver infrastructure  
- [main_commando.tf](https://www.nicenesecurity.com/assets/scripts/covenant_and_code/main_commando.tf) — provisions Commando VMs for operator use  
- [network.tf](https://www.nicenesecurity.com/assets/scripts/covenant_and_code/network.tf) — defines the VNet, subnets, and security groups  
- [variables.tf](https://www.nicenesecurity.com/assets/scripts/covenant_and_code/variables.tf) — manages all input values (with secrets externalized)

---

### You Are the High Priest of This System

Terraform may be your **covenantal lawgiver**, but you are the one tasked with **implementing the law faithfully**. Like Aaron standing between God and the people, you serve as the priest who:

- **Guards the boundaries** (constraints)  
- **Mediates the conditions** (variables)  
- **Communicates the blessings** (outputs)

Infrastructure as code isn’t just technical — it’s **liturgical**. Every declaration in a `.tf` file is a form of **worship**, of **order**, and of **obedience**.

---

### Theological Reflection: Law That Points Forward

In the end, just as the **Mosaic covenant** pointed toward the **new and better covenant in Christ**, your infrastructure law points toward something greater: **purpose, clarity, and mission**.

But **Christ is the true High Priest**, the one who **fulfills the law** and **mediates a better covenant**:

> “But as it is, Christ has obtained a ministry that is as much more excellent than the old as the covenant he mediates is better, since it is enacted on better promises.”  
>
> — *Hebrews 8:6*

So as you write variables and outputs, remember — this isn’t just provisioning machines. It’s practicing **dominion, order, and responsibility** in a world of chaos. And that’s a **sacred act**.

> “This is the covenant that I will make... I will put my law within them, and I will write it on their hearts.”  
>
> — *Jeremiah 31:33*

---

### Coming Next: Part III — Mission and Exile

> Now that your infrastructure is lawful, it must become **missional**. In Part III, we move into deployment strategies, stealth architecture, and cost-effective operations for red teamers “on the move.”

---

#### Recommended Reading | References


- [The Israelites Passing Through the Wilderness – William West](https://fineartamerica.com/featured/the-israelites-passing-through-the-wilderness-preceded-by-the-pillar-of-light-william-west.html)  
  A dramatic painting that visually captures Israel's covenantal journey, led by the pillar of light — ideal for evoking the theological weight of Sinai.

- [Terraform by HashiCorp](https://developer.hashicorp.com/terraform)  
  The official documentation hub for Terraform, providing guides, tutorials, and conceptual overviews.

- [Terraform Registry – Module Library](https://registry.terraform.io/browse/modules)  
  A public repository of reusable Terraform modules for various providers and configurations.

- [Futurice Terraform Examples (GitHub)](https://github.com/futurice/terraform-examples)  
  A collection of practical Terraform module examples maintained by Futurice, useful for learning structure and best practices.
