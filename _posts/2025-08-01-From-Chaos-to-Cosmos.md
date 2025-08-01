---
title: From Chaos to Cosmos - Choosing the Cloud and Designing Infrastructure
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

> "The earth was without form and void..."
>
> **Genesis 1:2**

## The Theological Theme: Choosing the Platform

God did not create randomly. He chose to create the *heavens and the earth*—a defined environment. And from nothing—_ex nihilo_—He brought forth all things by the sheer power of His Word. There was no pre-existing matter, no chaotic substrate to mold. Only the sovereign will of God, who spoke, and it came to be.

Creation didn’t begin with tools or templates. It began with a **decision**: _Where will I build?_ The Lord didn’t simply let matter coalesce into usefulness—He ordered it. He separated light from darkness, land from sea, heavens from earth. His design was deliberate, intentional, and purposeful. He formed the space before He filled it.

So too, before you write a single line of Terraform or spin up your first VM, you must decide: _Where will I build?_ What cloud environment will frame your lab? What realms will you define? What purpose will this infrastructure serve?

But the parallel doesn't end with design—it extends into **providence**. God not only creates—He **sustains**, governs, and directs all things toward their appointed end. Every subnet in your lab, every rule in your NSG, every dependency in your module has a purpose—just as every molecule in creation bows to His will. _“In Him all things hold together”_ (Col. 1:17).

To build infrastructure wisely is to mirror the divine pattern: not chaos, but cosmos; not randomness, but rule; not sprawl, but sovereignty.

You are not simply deploying servers—you are **exercising dominion** over a digital realm. So build like one who bears the image of the Creator: with clarity, order, and reverent intentionality.


So too, you must ask: **where will you deploy your lab?**

---

## 1. Surveying the Cloud Wilderness (Azure, AWS, GCP)

> "Let there be an expanse in the midst of the water..."
> 
> **Genesis 1:6**

![Azure versus AWS versus GCP](https://github.com/AthanasiusXOR/athanasiusxor.github.io/blob/main/assets/img/From-Chaos-to-Cosmos/AZ-vs-AWS-vs-GCP.png)

> "_Let there be an expanse in the midst of the waters, and let it separate the waters from the waters..._"
> 
> — **Genesis 1:6**

The first act of creation was **separation**—the formation of realms. God divided light from darkness, sea from sky, waters from dry land. In doing so, He established distinct domains, boundaries, and layers of purpose.

This is not mere compartmentalization—it is **sovereign architecture**. Every realm created by God is distinct in function, but unified in purpose under His rule. And so, the first step in building your infrastructure is a mirror of this act: **defining the environment** in which all else will live and operate.

In the same way that God chose to create *heaven and earth*—and not some other undefined space—you must choose **your cloud platform** with both **technical clarity and theological intentionality**. Your cloud provider becomes your “cosmic expanse,” the framework in which all other resources will be spoken into existence.

Here is a brief comparison of the cloud realms available to you:

| Provider   | Strengths                                           | Weaknesses                                      | Use in Lab Design                                  |
|------------|-----------------------------------------------------|--------------------------------------------------|-----------------------------------------------------|
| **Azure**  | Tight integration with AD, Defender, hybrid networks | High visibility by Defender, noisy default logs | Ideal for red team labs simulating enterprise nets |
| **AWS**    | Flexible, large ecosystem, low cost                 | Steeper learning curve for hybrid environments   | Best for modular, low-cost engagements             |
| **GCP**    | Fast setup, great for analytics                     | Weak community for red teaming, not AD-friendly | Niche use for analytics-focused labs               |

> 💡 **Note:**  
> This list of cloud providers (Azure, AWS, and GCP) is not exhaustive. Other platforms—such as Oracle Cloud, IBM Cloud, or self-hosted solutions—may also be used. Additionally, on-premises hardware and lab equipment can be purchased and integrated to create hybrid or fully custom environments.

Each cloud is a **domain** with its own ecology. Azure is like Egypt: rich and fortified, but under constant surveillance. AWS is the wilderness: expansive, flexible, but requires wisdom to navigate. GCP is a smaller province: fast and light, but limited in red team use cases.

> God **chose** the heavens and the earth. You must choose your platform with the same theological seriousness.

Do not choose based on fashion or familiarity. Choose based on **function and fidelity** to your lab’s mission. A wise architect counts the cost (Luke 14:28) before laying the foundation. A faithful image-bearer builds with eyes wide open to the terrain.

Remember: your cloud choice is not neutral. It shapes the entire environment. It affects scalability, visibility, integration, and cost. Like Eden, it sets the boundaries for what can grow and what must be guarded.

---

## 2. What Shall We Build? (Designing the Lab)

> "_Let the earth sprout vegetation..._"
> 
> — **Genesis 1:11**

Before vegetation filled the earth, God first shaped the **land**. He brought **form before filling**, structure before life. This is a foundational principle of divine creation: _nothing flourishes without form_. Likewise, your red team lab must not emerge from impulse or randomness—it must be designed with **deliberate intent**.

The modern temptation is to launch VMs before defining purpose, to test tools before shaping the terrain. But this reverses the divine order. If you are to build as an image-bearer of the Creator, then structure—**teleology**—must precede deployment.

### Your Lab is a Microcosm of Order

A well-formed lab does not merely exist to “test tools”—it simulates reality, exercises dominion, and supports repeated mission cycles. It is both a **sandbox** and a **stronghold**, a training ground and a battlefield. It should be **modular**, **segmented**, and **introspective**.

Here is a baseline structure to consider:

#### **Core Components to Include**:
- **Virtual Network (VNet)**: Forms the digital "landscape" of your lab. All resources live within its boundaries. This is your _earth_.
- **Subnets**: Segment your lab into regions or realms:
  - `Red Team Zone`: Operator infrastructure (e.g., Kali, Commando)
  - `Victim Zone`: Domain-joined targets, user workstations
  - `Management Zone`: Bastion host, DNS, logging servers
- **Network Security Groups (NSGs)**: Define and enforce boundaries. These are your “gates” and “walls,” preventing cross-contamination and controlling flow—just like the angel with the flaming sword guarded Eden (Gen. 3:24).

#### **Compute Resources**:
- **Kali Linux Operators**
- **Commando or Cobalt Strike TeamServer**
- **Windows Domain Controllers (DC)**
- **Windows Workstations (clients)**
- **Linux web servers or other attack surfaces**

#### **Optional, but Recommended**:
- **Bastion Host**: Secure ingress point with logging
- **Custom DNS**: For more realistic domain resolution
- **File Share / SMB Service**: For lateral movement testing
- **SIEM**: For defender emulation and blue team simulation (More on this in follow-on blogs about ethics and the importance of realistics testing environments)

> "_God is not a God of confusion but of peace..._"
> 
> — **1 Corinthians 14:33**

Chaos is not just insecure—it is unrighteous. Creation was structured, repeatable, and good. So too should your infrastructure reflect this pattern. Every component should have a **reason to exist**, a place to dwell, and a purpose to fulfill.

---

### Example Lab Topology (Diagram Placeholder)

Below is a rough outline of a potential lab topology. 

![Example Diagram](https://github.com/AthanasiusXOR/athanasiusxor.github.io/blob/main/assets/img/From-Chaos-to-Cosmos/Infrastructure-Operations.png)

> Use logical separation between red team operators, C2 infrastructure, and blue team/victim resources. Reflect the boundaries God placed between sea, land, and sky—not to divide maliciously, but to establish peace and order.

---

### Takeaway

Just as God formed the dry land before filling it with trees and creatures, so must you **shape your infrastructure before populating it**. Intentionality is not a luxury—it is a reflection of the divine image.

Ask yourself before deploying anything:  
**Why does this component exist? What domain does it belong to? And what good purpose will it serve?**

If you can answer those questions with clarity, then you are building more than a lab.  
You are echoing creation itself.

---

## 3. Why Infrastructure as Code is a Creation Mandate

> "_And God said... and it was so._"
> 
> — **Genesis 1:9**

![IaC](https://github.com/AthanasiusXOR/athanasiusxor.github.io/blob/main/assets/img/From-Chaos-to-Cosmos/Infrastructure-as-code-scheme.png)

This is the heart of the matter. **Infrastructure as Code (IaC)** is the _“Let there be…”_ of cloud computing. It reflects the nature of divine creation—not built by trial-and-error, not manipulated by hand, but spoken into existence through order, logic, and authority.

God creates **declaratively**. His speech is **effectual**—His Word *does* what He commands. _“Let there be light”_ was not a suggestion or a prototype—it was a decree, and light obeyed.

When you write [Terraform](https://developer.hashicorp.com/terraform/language/functions/templatefile), [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep), or [ARM templates](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/overview), you are acting in the same pattern: declaring what should exist, defining its properties, and trusting the execution engine to bring it into being.

### Divine Speech as a Model for Declarative Infrastructure

> "_By the word of the Lord the heavens were made, and by the breath of His mouth all their host._"
> 
> — **Psalm 33:6**

Creation was not random scripting—it was **ordered declaration**. Likewise, declarative infrastructure reflects a theology of:

- **Clarity** over chaos
- **Abstraction** over anxiety
- **Authority** over ambiguity

You declare what should be—not how to do it step-by-step. That’s the difference between **imperative chaos** and **declarative cosmos**.

---

### Benefits of IaC (Terraform, ARM, Bicep, Pulumi):

- **Scalability**:  
  > "_Be fruitful and multiply..._"  
  Labs should grow and adapt as needed—just like creation. Terraform modules allow you to scale across environments, regions, and teams, with consistency.

- **Repeatability**:  
  > "_And there was evening and there was morning, the second day._"  
  Each day of creation followed a repeatable liturgical rhythm. Similarly, IaC gives you predictable, reproducible builds—a kind of digital liturgy that ensures order.

- **Auditability**:  
  > "_And God saw everything that He had made, and behold, it was very good._"  
  You can track, version, and evaluate your infrastructure. What exists has been spoken—and it is known.

- **Stealth** (Avoiding Indicators of Compromise):  
  > "_The serpent was more crafty than any other beast..._"  
  IaC reduces human error. You can remove noisy mistakes like exposed ports, default names, or misconfigured security groups—things that give away your presence.

---

### The Image of the Creator in the Work of the Engineer

To write Infrastructure as Code is to mirror the divine act of creating with **intelligence, intentionality, and integrity**. You are not merely provisioning machines—you are **shaping realms**, establishing **laws**, and setting **boundaries**.

> "_Let all things be done decently and in order._"
> 
> — **1 Corinthians 14:40**

That’s the true power of IaC: it is not just automation. It is **ordered dominion**.  
You are not just a red team operator—you are a **digital image-bearer**, echoing the work of the Logos, the divine Word, by which all things were made (John 1:3).

Every `terraform apply` is a kind of doxology—declaring order where there was chaos, and preparing a lab not only to run, but to glorify God through its clarity, precision, and purpose.

---

Would you deploy infrastructure manually, with no order, no record, and no reflection?  
That is **not how God creates**. And it should not be how you build.

**Let there be IaC.**


## Terraform as Digital Genesis

In Genesis 1, God's creative work begins with a **spoken declaration** that results in **real, visible structure**:

> "_And God said, 'Let there be light,' and there was light._"
> 
> — **Genesis 1:3**

Infrastructure as Code mimics this same pattern. With a simple, declarative block of code, the unseen becomes seen. The void becomes ordered.

Here is a Terraform snippet that mirrors this moment of creation:

```hcl
# Let there be a virtual network
resource "azurerm_virtual_network" "lab_vnet" {
  name                = "let-there-be-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Let there be a subnet
resource "azurerm_subnet" "red_team_subnet" {
  name                 = "red-team"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.lab_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Let there be a Kali box
resource "azurerm_linux_virtual_machine" "kali_box" {
  name                = "kali-box"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_DS1_v2"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.kali_nic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "offsec"
    offer     = "kali-linux"
    sku       = "kali"
    version   = "latest"
  }
}
```

> "_And God saw everything that He has made, and behold, it was very good._"
>
> — **Genesis 1:31**

---

## 4. Avoiding Indicators of Compromise (Preserving the Goodness of Creation)

> "_And God saw that it was good._" 
> 
> — **Genesis 1:12**

It’s not enough to build. It must be *good*.

In Genesis 1, God's creative acts are followed by divine evaluation. He doesn't merely make—He **inspects**, and pronounces it good. This is a theology of **moral audit**: creation must reflect not only power, but wisdom and righteousness. So too, your infrastructure must not only work—it must be secure, subtle, and free from careless exposure.

**Goodness in your lab is inseparable from operational integrity.** A poorly configured lab can do harm—by leaking IPs, exposing command and control paths, or triggering unnecessary detections in Azure Defender or Sentinel. A good lab is one that reflects both **technical craftsmanship** and **ethical restraint**.

Here are baseline ways to preserve this “goodness”:

- **Use private IPs whenever possible**  
  The cloud is not Eden. Exposure is exile. Keep your Kali boxes and C2s internal, and use bastion or jump boxes for ingress.

- **Define tight NSGs (Network Security Groups)**  
  Think like a temple builder. Only the right things should enter the right zones. Don’t permit inbound RDP/SSH on 0.0.0.0/0. Gatekeeping is holy work.

- **Avoid obvious VM names**  
  Naming a host `kali-victim-1` is like wearing a red team jersey during recon. Use generic labels, randomized hostnames, or something the blue team would overlook.  
  (_Pro tip_: use theological or literary references, like `orthanc-vm`, `pilgrim-node`, or `petra-fileshare`.)

- **Store secrets in Azure Key Vault or encrypted files**  
  Never hardcode creds in Terraform or shell scripts. What is secret must remain sacred.

- **Plan for teardown and burn-back**  
  Every red team engagement should assume compromise. Use `terraform destroy`, snapshots, and burn scripts to tear down after testing. Sabbath rest includes renewal.

> 💡 **Note:**
> Stay turned for Part II: Covenant and Code - Building Lawful Infrastructure with Terraform, where we will dive deeper into Terraform scripting and Iac.

> "_Better is the end of a thing than its beginning..._"  
>
> — **Ecclesiastes 7:8**

---

## Your Lab is a Liturgy

> "_On the seventh day God finished His work that He had done, and He rested..._"  
>
> — **Genesis 2:2**

Creation ends with rest—not abandonment, but satisfaction. Rest means that everything necessary has been built, ordered, and protected.

**Your lab is not merely a technical artifact—it is a liturgical act.** Every `terraform apply` is a declaration. Every VM is a priest in a sanctuary of testing. Every subnet a courtyard. Every NSG rule a veil.

To build well is to build **with rhythm and reverence**.

- Your infrastructure has a **weekly cadence**—build, test, destroy, rebuild
- Your deployments follow **repeatable liturgy**—apply, verify, harden, observe
- Your architecture is shaped by **wisdom and discipline**, not mere enthusiasm

The red teamer is not just an engineer. He is a **craftsman in the image of the Creator**, called to order the digital wilderness and guard against evil within it.

> "_Let all things be done decently and in order._"  
>
> — **1 Corinthians 14:40**

Let your lab reflect that order. Let it rest when the mission is done. Let it teach you not just tactics—but theology.

---

## Coming Next: Part II — Covenant and Code

> In Part II, we will move from choosing the terrain to forming the law. Terraform modules, remote state, secret management, and repeatable infrastructure will be our Sinai. You’ve chosen your mountain—now it’s time to meet with fire.

---

#### Recommended Reading | References


- [**Outplay Your Adversary: Red Teaming Tactics for AWS, Azure, and GCP**](https://tushara2517.medium.com/outplay-your-adversary-red-teaming-tactics-for-aws-azure-and-gcp-7f722a5ee7f5) — Tushar Verma’s detailed overview (Aug 15, 2024) of cross‑cloud red teaming strategies, covering identity misconfigurations, lateral movement, privilege escalation, API exploitation, and persistence across AWS, Azure, and GCP :contentReference[oaicite:1]{index=1}.

- [**Azure vs AWS Pricing Comparison**](https://azure.microsoft.com/en-us/pricing/azure-vs-aws) — Microsoft’s official comparison showcasing Azure’s cost and performance advantages for workloads such as Windows Server and SQL Server—often delivering up to ~57 % better performance at ~54 % lower cost for Azure VMs versus AWS EC2 :contentReference[oaicite:1]{index=1}.

- [**Microsoft Azure vs GCP vs AWS: Comparison Guide**](https://kitrum.com/blog/microsoft-azure-vs-gcp-vs-aws-comparison-guide/) — An in-depth side-by-side analysis of Azure, Google Cloud Platform (GCP), and AWS, covering key features, pricing models, security posture, compliance standards, and suitability for various enterprise scenarios.
  
- [**Infrastructure as Code: What Is It and Its Benefits**](https://blog.sparkfabrik.com/en/infrastructure-as-code-what-is-it-and-its-benefits) — A concise and insightful overview from SparkFabrik, outlining how IaC transforms infrastructure management by enabling scalable, reproducible, and business-aligned provisioning practices.

- [**Terraform `templatefile` Function**](https://developer.hashicorp.com/terraform/language/functions/templatefile) — Official HashiCorp documentation explaining how to dynamically generate content from templates using input variables. Useful for modular and reusable IaC design.

- [**Azure Resource Manager (ARM) Templates Overview**](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/overview) — Microsoft’s foundational guide to using ARM templates for declarative infrastructure deployment in Azure.

- [**Bicep Overview**](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep) — An introduction to Bicep, a domain-specific language (DSL) for simplifying Azure Resource Manager deployments. Bicep offers a more readable alternative to JSON-based ARM templates.
