---
title: "Azure Terraform Infrastructure (Part III): Azure Front Door in Red Team Infrastructure"
date: 2025-03-01
categories: [red-team, infrastructure, azure, terraform]
tags: [cobalt-strike, azure-front-door, redirectors, payload-delivery, operational-security]
---

> *"And the Word became flesh and dwelt among us... full of grace and truth." — John 1:14*

---

> ⚠️ **Use With Integrity**  
All techniques shown are for authorized environments only.  
We pursue **righteous intrusion** — not reckless exploitation.  
> *“Abstain from every form of evil.” — 1 Thessalonians 5:22*

---

## I. Introduction: The Theology of Delivery

This is **Part III** of our Azure Infrastructure series.

If **[Part I](https://nicenesecurity.com/posts/Red-Team-Infrastructure-Part-I/)** laid the philosophy, and **[Part II](https://nicenesecurity.com/posts/Red-Team-Infrastructure-Part-II/)** the deployment, **Part III** focuses on the *delivery path* — the often-overlooked but critical mechanics of **command-and-control flow**, **CDN chaining**, and **payload redirection**. This is where offensive infrastructure meets real-world adversary emulation and theological clarity.

Like the Incarnation, which brought truth through embodied presence, red team payloads must be **delivered with purpose**, **arrive unseen**, and **be prepared for resistance.**

---

## II. Why Use CDN Chaining?

Cloud-based CDN services such as **Azure Front Door** (AFD) provide more than traffic distribution — they enable:

- **IP abstraction** for redirectors and C2s
- **TLS termination** with custom domains
- **WAF evasion** by chaining traffic through trusted providers
- **Operational flexibility** for domain and region failover

### Example Path

Victim → nicenesecurity.com (Azure Front Door) → Redirector (NGINX) → C2 TeamServer

![CDN to Redirector to TeamServer](assets/img/Azure-Infrastructure/CDN-Redirector-Cobaltstrike.png)

This obfuscates backend infrastructure and improves both **stealth** and **stability**.

---

## III. Configuring Azure Front Door

### 1. Create a Front Door Profile

> A virtual infrastructure needs to be deployed prior to establishing the Azure Front Door. For instruction on builidng the initial infrastructure, please see [Part I](https://nicenesecurity.com/posts/Red-Team-Infrastructure-Part-I/) and [Part II](https://nicenesecurity.com/posts/Red-Team-Infrastructure-Part-II/).

Once the Vritual Machine(s) and the network has been deployed, then brothers, we can move tot he next phase of the deployment. 

#### a. Firewall Rules

The TeamServer Virtual Machine will be installed with a basic firewall. We will need to manually adjust, change, and add firewall rules to meet/match our requirements. We will start by adding two (2) rules for web traffic. 

![TeamServer Firewall](assets/img/Azure-Infrastructure/AzureFrontDoor_Firewall.png)

The image above is for the HTTPS rule, we will repeat this for the HTTP Firewall rule. 

![TeamServer Firewall 2](assets/img/Azure-Infrastructure/AzureFrontDoor_Firewall1.png)

We establish these rules because Microsoft publishes their Azure IP ranges and Service Tags on their site in JSON files called *ServiceTags_Public.json*. This file contains the IPv4 address for PUblic Azure Networks as a whole, divided by regions and service. This file get updated weekly.

#### b. Creating the Azure Front Door

- Go to Azure Portal → Front Door and CDN Profiles
- Click *Create a resource* → *Front Door (standard/premium)*

![Create Azure Front Door](assets/img/Azure-Infrastructure/CDN_Configuration1.jpg)

![Azure Front Door Creation](assets/img/Azure-Infrastructure/CDN_Configuration1.png)

### 2. Add a Custom Domain

- Ensure your domain (e.g., `nicenesecurity.com`) is managed through your DNS provider (e.g., Namecheap)
- Add a `CNAME` record pointing to the Front Door endpoint

![Azure Front Door Custom Domain](assets/img/Azure-Infrastructure/CDN_Creation.png)

![Azure Front Door Custom Domain 1](assets/img/Azure-Infrastructure/CDN_Creation1.jpg)

### 3. TLS & HTTPS

- Use Azure-managed certificate or upload your own
- Enforce HTTPS for secure delivery

### 4. Routing Rules

- Create routes from `nicenesecurity.com/*` → backend pool (e.g., `Redirector1`)
- Configure **URL path patterns** to match your phishing or beaconing endpoints

![Default Route](assets/img/Azure-Infrastructure/DefaultRoute.png)

![Default Route 1](assets/img/Azure-Infrastructure/DefaultRoute1.png)

### 5. Backend Pool Configuration

- Add your public-facing redirectors
- Health probe should use a benign path (e.g., `/robots.txt`)
- Disable caching if you're handling dynamic traffic (payloads, beacons)

---

## IV. Redirectors: Optional Layer of Stealth

While not strictly required, redirectors offer an additional veil — one that increases operational **plausibility**, provides **network segmentation**, and enables **fine-tuned control** over ingress traffic.

> *They are the veil before the temple — not the temple itself.*

Redirectors using Apache or NGINX can forward traffic from Azure Front Door to your actual TeamServer or tooling infrastructure. They enable:

- **Header-based filtering** to reject unwanted requests  
- **Operational logging** for audit trails  
- **Payload shaping and delivery** with minimal exposure  

If you choose to include them, configure them carefully with limited exposure and clean routing.

_A future guide will walk through this in depth._

---

## V. Looking Ahead: C2 Profiles & Redirector Strategy

This guide does **not** cover malleable C2 profiles or advanced redirector logic — but those pieces matter deeply in blending into real traffic.

We’ll explore:

- **Cobalt Strike profile hardening**  
- **CDN-style header mimicking**  
- **`uri_x86` and `uri_x64` routing**  
- **Sleep, jitter, and jittermax**  
- **Redirector-to-C2 architecture design**

> *This will be unpacked in a future post.*


For public examples, see: [https://github.com/rsmudge/Malleable-C2-Profiles](https://github.com/rsmudge/Malleable-C2-Profiles)

---

## VI. Theology of Hiddenness

Jesus walked among us, not always revealed — but always redemptive. In red teaming, obfuscation is not about deception for harm — it is the method of testing, of truth-discovery. Your infrastructure should reflect the wisdom of **stealth without sin**.

> *"It is the glory of God to conceal a matter; to search out a matter is the glory of kings." — Proverbs 25:2*

---

## VII. Final Checklist

- [ ] Azure Front Door configured and TLS secured  
- [ ] Custom domain mapped and resolving  
- [ ] NGINX/Apache redirectors forwarding cleanly  
- [ ] C2 Profile hardened and deployed  
- [ ] Redirector logs monitored for signal  
- [ ] Payload delivery tested successfully

---

## Coming Next: Payload Development & Righteous Intrusion

> *"No creature is hidden from His sight, but all are naked and exposed to the eyes of Him to whom we must give account." — Hebrews 4:13*

This upcoming series explores the *craft* and *conscience* of payload development.

We'll walk through:

- 🧾 Identifying signed executables trusted by the system  
- 🔗 Discovering and abusing third-party DLL load paths  
- 🪝 Mapping binary trust chains and execution flow  
- 🧠 Developing a theological method for red team payload ethics

Each post will include:

- Real-world methodology  
- Payload design and execution tips  
- Theological reflections on truth, obfuscation, and spiritual warfighting

This isn’t just code.  
This is confrontation.

The first post — *“Signed Executables and Subverted Trust”* — drops soon.

> *“We destroy arguments and every lofty opinion raised against the knowledge of God, and take every thought captive to obey Christ.” — 2 Corinthians 10:5*

**Stay disciplined. Stay hidden. Stay holy.**
