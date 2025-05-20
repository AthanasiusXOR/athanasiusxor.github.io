---
title: "Azure Terraform Infrastructure (Part I): Methodology and Philosophy"
date: 2025-05-20
categories: [red-team, infrastructure, azure, terraform]
tags: [terraform, azure, infrastructure, methodology, red team]
---


> *“Do not despise the day of small beginnings.” — Zechariah 4:10*

---

## Introduction: Building with Conviction

Before the first payload is launched or the first beacon configured, there must be a blueprint — not just of code, but of conviction.

This blog series is not merely about spinning up virtual machines or automating deployments with Terraform. It’s about building **red team infrastructure that reflects purpose, precision, and principle** — infrastructure that is theologically rooted, tactically sound, and missionally aware.

- We don’t build simply to breach.  
- We build to reveal.  
- To refine.  

To ready ourselves for confrontation — both technical and spiritual.

And that begins with **where** and **how** we build.

> *"Unless the LORD builds the house, those who build it labor in vain." — Psalm 127:1*

---

## ☁️ Choosing a Cloud: Azure vs. AWS vs. GCP

In today’s threat landscape, red teamers must build infrastructure with both **precision** and **plausibility**. Cloud providers aren’t just tools — they’re terrain. The environment you operate from influences how you're perceived, how long you persist, and how effectively you emulate real-world adversaries.

![Microsoft vs Amazon vs Google](/assets/img/Azure-Infrastructure/AZ-vs-AWS-vs-GCP.png)

We considered three primary providers:

---

### 🟦 Microsoft Azure

- **Enterprise Mirror**: Azure is the backbone for many Fortune 500s and government environments — making it ideal for adversary simulation.
- **Terraform-Native**: Excellent support for infrastructure-as-code, clean state management, and rapid provisioning.
- **IP Legitimacy**: Blue teams are slower to blacklist Azure-owned IPs, allowing greater stealth.
- **Role-Based Access Controls (RBAC)**: Native granularity for tightly scoped operator privileges.
- **Service Consistency**: Resources deploy in predictable ways across global regions.

> **Verdict**: Chosen for its *stealth, structure, and spiritual symmetry* — Azure mirrors the targets we train against, and supports a modular theology of systems.

---

### 🟨 Amazon Web Services (AWS)

- **Mature Ecosystem**: Largest and most diverse cloud offerings — but complexity often becomes a burden.
- **Noisy by Default**: Many AWS IP ranges are aggressively monitored and blocked.
- **Strong Terraform Support**: But high friction on network and IAM management for red teams.
- **Great for Detections, Not Deception**: Blue teams are trained to watch AWS more closely.

> **Verdict**: Excellent for experimentation or blue team use, but its signal profile is too loud for long-term offensive infrastructure.

---

### 🟥 Google Cloud Platform (GCP)

- **Easy to Start, Hard to Customize**: Clean UI and fast VM creation — but weaker support for nuanced red team deployments.
- **Limited Terraform Maturity**: Provider support is improving, but documentation lags behind.
- **Uncommon**: Because fewer enterprises use GCP, red team infrastructure hosted here often stands out rather than blends in.

> **Verdict**: Ideal for research environments, not realistic engagements.

---

## 🧠 Theological Note

We didn’t just choose Azure because it was convenient — we chose it because it represents the principle of **emulation**, not just execution. To test faithfully, we must **build environments that resemble what we seek to refine**.

> *"Be wise as serpents and innocent as doves." — Matthew 10:16*

---

## I. Overview: Red Team Objectives

Our Red Team operates with one guiding principle: build what you’re willing to burn. Our infrastructure is designed to be:

- **Modular**: Easy to scale up or destroy  
- **Isolated**: Compartmentalized by function  
- **Ethically sound**: Used only in authorized assessments  
- **Spiritually clear**: Rooted in conviction, not chaos  

We believe red teaming is a form of testing the gates — and every gate we build must reflect the clarity and strength of our theological witness (Bonhoeffer, 1949; cf. Jude 3).

---

## II. Core Infrastructure Layout

The following systems form the foundation of a our red team deployment:

### 🔍 Kali0
- Purpose: Recon/scanning only  
- Design: Subnet-isolated to prevent exposure to the rest of the infrastructure

### 🧠 Kali1 & Kali2
- Purpose: Primary operator workstations  
- Configured with RDP access for usability during long ops

### 🎯 GoPhish Server
- Purpose: Credential harvesting and phishing payload delivery

### 🕸 Evilginx
- Purpose: Reverse proxy for GoPhish, man-in-the-middle campaign support

### 🛠 TeamServer (CobaltStrike)
- Purpose: Core command-and-control  
- Considered a high-value asset, often shielded behind redirectors

### 🔀 Redirectors (1 & 2)
- Purpose: Payload hosting, redirect chaining, [Nemesis](https://github.com/SpecterOps/Nemesis)
- NGINX or Apache with specific header filters or C2 profiles

### 🧪 Windows0
- Purpose: Testing payloads and post-exploitation tooling (e.g. Commando)

> Note: Not all infrastrucutre are the same. Make appropriate and scaled decisions that reflect the light of your team's needs.

![Red Team Infrastructure via Azure](/assets/img/Azure-Infrastructure/Azure-Network-Diagram.png)

---

## III. Not Deployed by Default: Manual Elements

The following are **not** provisioned automatically but are essential:

- **[Azure Front Door (CDN)](https://azure.microsoft.com/en-us/products/frontdoor)**: Used to obfuscate TeamServer IPs and add redundancy  
- **DNS**: Used for domain redirection and SSL chaining

> *“The counsel of the LORD stands forever, the plans of His heart to all generations.” — Psalm 33:11*

Though we’ve mapped the architecture, we have not yet sealed the gate.

Azure Front Door and DNS configuration — the entry point and naming authority of this red team cathedral — will not be left in the ark. We will walk through them in **Part II** and **Part III**, where theory becomes deployment, and conviction meets execution.

---

## IV. Terraform File Structure

Your working directory should include:

```
terraform/
├── terraform.exe
├── main.tf
├── network.tf
├── variables.tf
├── kali_installation.sh
├── teamserver_installation.sh
├── gophish_installation.sh
├── evilignx_installation.sh
├── id_rsa.pub
├── id_rsa1.pub
```

In **Part II** we will walk through each of these files and discuss how they are laid out and what pertinent information will be needed. 

---

## V. Key Methodological Considerations

- **Compartmentalization**: Recon machines do not touch payload servers  
- **Hardcoded but modifiable RDP credentials**: For Kali + Windows usage, change both `variables.tf` and the `kali_installation.sh`  
- **Key Discipline**: SSH keys are named `<OperatorLastName_OperationName>` for auditability  
- **Mission Naming**: Every Resource Group is named after its assigned operation — clear, ephemeral, and reportable  

> We agree with Red Canary’s principle: *"Automated infrastructure makes red teams faster, more disciplined, and less fragile."* ([Red Canary, 2020](https://redcanary.com/resources/webinars/atomic-red-team-scale-testing/))

---

## VI. What's Next: From Blueprint to Battleplan

The infrastructure is drawn. The purpose is clear. But intentions must become execution.

In **Part II**, we will move from methodology to implementation — from design to deployment — walking through every command, configuration, and customization required to build FAST infrastructure with both stealth and conviction.

> *“Commit your work to the LORD, and your plans will be established.” — Proverbs 16:3*

### What we’ll cover:

- Writing and customizing your `variables.tf`  
- Running `terraform init`, `plan`, and `apply`  
- Authenticating with Azure CLI and deploying resources  
- Configuring Azure Front Door and DNS for stealth and redundancy  
- Installing core tooling: Cobalt Strike, Commando VM, SMB shares  
- Establishing operational hygiene and post-deploy hardening  

This is where the theology of infrastructure meets the theology of execution.  
**[Part II]()** and **[Part III]()** is not just technical — it is tactical. Missional. Faithful.

> *"Build it like you're going to breach it. Harden it like you mean it. And deploy it like someone is watching."*

---

## References

- Bonhoeffer, D. (1949). *Ethics*. Fortress Press.  
- HashiCorp. (n.d.). *Terraform Documentation*. Retrieved from [https://developer.hashicorp.com/terraform/docs](https://developer.hashicorp.com/terraform/docs)  
- Microsoft. (n.d.). *Azure Architecture Center*. Retrieved from [https://learn.microsoft.com/en-us/azure/architecture/](https://learn.microsoft.com/en-us/azure/architecture/)  
- Forrester Research. (2021). *The Total Economic Impact™ of Microsoft Azure IaaS*. Microsoft.  
- Jude 3, ESV. *"Contend for the faith that was once for all delivered to the saints."*
