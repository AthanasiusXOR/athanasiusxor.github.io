---
title: "Outpacing the Watchers (Part I): Doctrine and Design"
date: 2025-06-15
categories: [red-team, malware, edr-evasion, theology]
tags: [dll sideloading, edr, cobalt strike, supralapsarianism, infralapsarianism]
---

> *“You shall know the truth, and the truth shall set you free.” — John 8:32*

---

> ⚠️ **Use With Integrity**  
All techniques shown are for authorized environments only.  
We pursue **righteous intrusion** — not reckless exploitation.  
> *“Abstain from every form of evil.” — 1 Thessalonians 5:22*

---

![Outpacing the Watchers Banner](assets/img/ExploitDev/Outpacing-the-Watchers.png)

## Introduction: What We Build, We Must Justify

Red teaming is never neutral. Tools shape tactics, and tactics reflect theology. This blog series is not a glorification of malware but a **missional journey into the logic of intrusion** — why we build, how we test, and what we defend in the shadows.

This project came from one of my most demanding tasks to date: building custom tooling that could **bypass EDR platforms** like Cortex XDR and CrowdStrike Falcon during a live, high-friction engagement — all while remaining **ethically sound and theologically aware**.

---

## I. Theology of Adversarial Testing

The red team operator is not merely an adversary — he is a revealer. In high-signal environments where defenders monitor everything, even our **presence is a confession**.

We don't evade detection to glorify stealth — we do it to expose weakness **without violating holiness**.

> *"Examine everything; hold fast what is good." — 1 Thessalonians 5:21*

We build because truth matters. And to confront false security, you must build what sees through illusion.

---

## II. The Cybersecurity Trinity

Every tool I build reflects a model I’ve come to call the **Cybersecurity Trinity**:

- **Reconnaissance (The Father)** — Source of all understanding, distant yet sovereign  
- **Exploitation (The Son)** — Made manifest in execution, visible in action  
- **Persistence & Evasion (The Spirit)** — Quiet, subtle, enduring presence  

This series is not just a technical breakdown — it’s a **devotional architecture of intrusion**.

![Cybersecurity Trinity](assets/img/Trinity.png)

---

## III. Supralapsarianism vs. Infralapsarianism in Payload Development

In Reformed theology, the debate between **Supralapsarianism** and **Infralapsarianism** concerns the logical order of God's decrees. Likewise, in red teaming, we face a similar architectural choice: do we craft payloads before or after we know the path of exploitation?

> "The key issue here is whether to consider the decree to elect and to reprobate logically before (supra-) or after (infra-) the decree to create and to permit the fall. The counsel of God is to be understood as his eternal plan for all that exists or will happen in time. Scripture everywhere assumes that all that is and comes to pass is the realization of God's thought and will and has its model and foundation in God's eternal counsel. God is not identified with his decree; his self-knowledge is not exhausted in creation, providence, and redemption"
>
>
> Herman Bavnick, *Reformed Dogmatics*

### 🔷 Supralapsarian Payload Design

**Supralapsarianism** holds that the decree to save precedes the decree to allow the fall. Translating this into payload design:

- Payloads are crafted **before** knowing the exact exploit path.
- Shellcode loaders, stagers, and beacons are written **in anticipation** of opportunity.
- We build as if compromise is coming — not reacting, but preordaining.

> To craft your loader before finding your sideloading path is to design with divine foresight.

### 🔶 Infralapsarian Payload Design

**Infralapsarianism** teaches that the decree to redeem follows the allowance of the fall. Applied here:

- Payloads are built **after** the sideload path is discovered.
- Recon and enumeration guide the design.
- We **respond** to the opportunity, embedding code based on the actual context.

> Infralapsarian payloads are acts of precision: built not on faith alone, but on observation and obedience.

Together, these doctrines form a red team methodology: *build with anticipation, refine through revelation*.

---

## IV. Reconnaissance: Understanding the Watchers

EDR is no longer a tool — it’s a sentry.

[Cortex XDR](https://www.paloaltonetworks.com/cortex/cortex-xdr), [CrowdStrike Falcon](https://www.crowdstrike.com/platform/endpoint-security/), [Microsoft Defender](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint?view=o365-worldwide) — these are not static tools. They are watchers. Correlating behavior, ingesting logs, flagging patterns. They do not sleep. They do not forget.

Our reconnaissance phase asked:

- Which binaries are digitally signed?
- What processes whitelist DLLs?
- What telemetry trips EDRs?
- What IOCs are extractable from Cobalt Strike?

This is our **doctrine of surveillance**: know the watchers before you outpace them.

> *"The thief comes only to steal and kill and destroy..." — John 10:10*

---

## V. DLL Hijacking and the Fall of Trust

When a Windows application starts, it looks for DLLs — small code libraries for graphics, file access, and more. If the expected DLL is missing, Windows searches alternate paths:

- Application directory  
- System directories  
- Desktop or `%APPDATA%`  
- Removable media

If a malicious DLL with the same name is found **first**, it’s loaded **without question** — often **undetected**.

This is **DLL Hijacking** — a fundamental trust flaw in the OS’s behavior.

> If the parent process runs as Admin, so does the malicious DLL.

---

## VI. Exploiting Misplaced Trust

DLL Sideloading and Hijacking are not just exploits — they are parables of misplaced trust.

- Windows trusts the path  
- EDR trusts the signature  
- Blue teams trust the lineage  

But an attacker trusts neither and **questions everything**.

### 🧩 Sideloading (Signed Executable Path Abuse)

A signed binary loads a malicious DLL from its local directory. Often used in passive delivery:

- Drop binary + malicious DLL  
- Run binary  
- Payload executes

- ![DLL SideLoading](assets/img/ExploitDev/DLLSideloading.png)

### 🧩 Hijacking (Search Order Manipulation)

An app references a DLL that isn’t there. The attacker places a spoofed DLL in a higher-precedence directory:

- `%TEMP%`, `%APPDATA%`, or same-folder  
- Phantom DLLs offer persistent injection points

![DLL Hijacking](assets/img/ExploitDev/DLLHijacking.png)

---

## VII. Reflection: What We Trust, We Exploit

> *“He who walks in integrity walks securely, but he who makes his ways crooked will be found out.” — Proverbs 10:9*

Red teaming is the theology of exposure.

- **Supralapsarian builds** reflect sovereignty and foresight  
- **Infralapsarian builds** reflect responsiveness and precision  

When we exploit trust, it’s not to destroy — it’s to reveal what was always vulnerable. Security is not about hiding. It's about holiness.

---

## VIII. What’s Next: Crafting the Loader

In Part II, we’ll explore:

- Identifying signed binaries
- Decompiling dependencies
- Shellcode injection via `VirtualAlloc`, `NtCreateThreadEx`, and `QueueUserAPC`
- Using XOR-encoded shellcode and obfuscated execution chains

> *“For nothing is hidden that will not be made manifest, nor is anything secret that will not be known and come to light.” — Luke 8:17*

Stay discerning. Stay dangerous — but holy.

---

> 🔒 **Disclaimer**  
This series is intended **only for lawful red team assessments** conducted with explicit authorization. All tooling, methods, and theology shared are grounded in **ethical usage and spiritual clarity**.

**Security without righteousness is just subversion.**

---

**AthanasiusXOR**  
**Contra Mundum. Code Obscurum.**

