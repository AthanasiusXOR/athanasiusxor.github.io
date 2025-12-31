---
title: Part II of the Ecology of Command and Control - Open-Source C2s and the Great Reformation
date: 2026-03-01
tags: [c2, cobalt-strike, mythic, sliver, adaptix, experimental, theology, providence]
categories: [red-team, c2, theology]
---
## ⚠️ Ethical & Legal Disclaimer: Wisdom Governs Knowledge

> ⚠️ The infrastructure, code, and methodologies described in this blog are designed **solely for lawful, educational, and ethical purposes**. This series is intended to help red team professionals, security researchers, and students build controlled environments for testing, training, and strengthening defensive postures.
>
> As those made in the image of God and called to walk in integrity, we affirm that knowledge must be governed by wisdom. The Apostle Paul reminds us, _“All things are lawful, but not all things are helpful”_ (1 Cor. 10:23). Accordingly, these tools are not to be used for harm, unauthorized access, or malicious activity of any kind.
>
> Let it be clear: **this work is to be conducted with a clear conscience before both God and man** (Acts 24:16). Those who weaponize such knowledge outside the bounds of legality and virtue not only violate human law, but grieve the moral law of the Creator Himself.

> “Whatever you do, in word or deed, do everything in the name of the Lord Jesus...”
>
> — **Colossians 3:17**
---

# Part II — Open-Source C2s: The Great Reformation

![MARTIN LUTHER AND THE REFORMATION](https://www.nicenesecurity.com/assets/img/Command-and-Control/The-Reformation.png)

> “For where two or three are gathered in my name, there am I among them.”
> — **Matthew 18:20**

**Representative tools:** *Mythic, Havoc, Sliver, Covenant, PoshC2, Empire.*

### The Decentralized Pulpit: A Priesthood of All Operators

![Decentralized Pulpit](https://www.nicenesecurity.com/assets/img/Command-and-Control/Decentralized_Pulpit.png)

If proprietary C2s represent the established "Cathedrals" with their centralized authority and guarded sacraments, then open-source C2s are the **"Reformation."** They embody a radical decentralization of power, democratizing offensive capabilities and fostering what we might call a "priesthood of all operators."

The rise of tools like **Mythic**, **Havoc**, and **Sliver** was a direct challenge to the perceived "indulgences" of proprietary systems—their high costs, black-box methodologies, and the limitations of their often-monolithic frameworks. Open-source C2s brought:

* **Accessibility:** They lowered the barrier to entry, allowing any operator with technical acumen to wield advanced offensive tools without a corporate license.
* **Transparency:** They allowed operators to inspect the "scriptures" (source code), understanding every line of execution and contributing their own "interpretations" (modules).
* **Customization:** They empowered users to fork, modify, and extend tools to their exact needs, bypassing the "dogma" of a single vendor's design.

---

### The New Theologies: Python, Go, and the Rise of RPC

Open-source C2s represent a diversity of "theologies," often reflecting core programming language choices and their underlying architectural philosophies.

![New Theologies](https://www.nicenesecurity.com/assets/img/Command-and-Control/New_Theologies.png)

#### 1. Python-Based C2s (e.g., Mythic, PoshC2): The Interpreted Word
Earlier foundational texts like **Empire** paved the way for modern, modular frameworks like **Mythic**.
* **The Strength:** Rapid development and ease of modification. Operators can quickly write custom "sermons" (modules) to execute specific functions.
* **The Weakness:** Reliance on an interpreter can leave a larger memory footprint and a more predictable "shape" for defensive scanning.

#### 2. Compiled C2s (e.g., Havoc, Sliver): The Self-Contained Gospel
More recent frameworks have moved toward compiled languages like **Go** (Sliver) or **C++** (Havoc).
* **The Strength:** Smaller binaries, fewer dependencies, and high performance. Go, in particular, excels at cross-compilation, allowing operators to target multiple operating systems with a single "gospel" (binary).
* **The Weakness:** Slower development cycles for custom modules and less flexibility for on-the-fly modifications compared to interpreted languages.

#### 3. RPC & Modern Agent Architectures: The Universal Language
Advanced open-source C2s have moved towards **Remote Procedure Call (RPC)** architectures. This allows operators to build agents in almost *any* language—Rust, Zig, or Nim—as long as it can communicate back to the C2 framework. This is the ultimate expression of the "priesthood," where the agent's form is limited only by the operator's imagination.

---

### Open-Source Tradecraft: Democratizing the Subversion

While proprietary tools rely on polished, automated routines, Open-Source tradecraft thrives on the ability to "fork the code." The operator isn't just a user; they are a contributor to the subversion. In this "Reformation," the secrets of the high priests are made public, allowing every operator to tailor their tools to the specific environment.

#### 1. Hardware Breakpoints: The Reformation of Hooks
If the Cathedral uses Indirect Syscalls, the Reformation often utilizes **Hardware Breakpoints (HWBP)**. While many frameworks implement 'HellsGate' or 'HalosGate' to dynamically resolve syscalls, the more elegant approach for bypassing active hooks is using the CPU's own debug registers ($DR0$ through $DR7$).

Instead of overwriting the EDR's hook (which is easily detected by integrity checks), the agent sets a hardware breakpoint on the function it wants to call. 

* **The Result:** When the code executes, the CPU triggers a "Single Step" exception *before* it hits the EDR’s hook. The agent’s exception handler captures this, redirects execution to its own custom code, and avoids the "gatekeeper" entirely. It is a technical "protest" against the forced liturgy of the EDR.

#### 2. Synthetic Stack Pivoting: The New Identity
In the Open-Source era, we don't just "forge" the ancestry; we pivot to an entirely different lineage. Open-source research—pioneered by innovators like Mariusz Banach—has led to **Synthetic Stack Pivoting**.

Instead of just pushing addresses onto the existing stack (which can still look suspicious), the agent allocates a brand-new, legitimate-looking stack in memory that mimics a real thread.

* **The Deception:** When the agent performs a sensitive operation, it switches the Stack Pointer ($RSP$) to this new, "clean" stack. To an EDR scanner, the thread appears to be executing from a perfectly valid, file-backed location. The "original sin" of the malicious memory remains hidden in a completely different sector of the CPU's memory space.

#### 3. Fluctuating Memory: The Living Sacrifice
In the Open-Source Reformation, Sleep Masking has evolved into **Memory Fluctuating** (e.g., *ShellcodeFluctuation*). Rather than just XOR-encrypting the memory, Open-Source agents use **Read/Write/Execute (RWX)** transitions to change their very nature.

When the agent sleeps, it doesn't just encrypt its code; it changes the memory protection from **Executable** to **Read-Only**.

* **The Logic:** Most memory scanners prioritize searching for **Executable** memory (where active code lives). By voluntarily "dying" to its executable state during sleep, the agent disappears from the scanner's primary radar. It effectively becomes "dead to the law" of the scanner until it is resurrected by a timer or APC, once again taking on the form of active code.

```
// The "Reformation" Loop: Changing Memory Protections
// Transitioning from RWX to RW during sleep to evade scanners.
func fluctuate(address uintptr, size uintptr, protect uint32) {
    var oldProtect uint32
    // Changing memory state to Read/Write while dormant
    VirtualProtect(address, size, PAGE_READWRITE, &oldProtect)
    
    // ... Sleep occurs here ...
    
    // Restoring to Execute/Read on wake
    VirtualProtect(address, size, PAGE_EXECUTE_READ, &oldProtect)
}
```

### The Blue Team Response: From Signatures to Semantic Analysis

The Open-Source Reformation has shattered the monolithic targets of proprietary C2s, forcing the Blue Team to evolve from signature-based "Law" to advanced **Semantic Analysis**.

* **Behavioral Anomaly Detection:** Instead of looking for specific tool signatures, defenders focus on **chains of suspicious behavior**. They look for the "Spirit" of the OS—identifying when a process like `msiexec.exe` begins acting in a way that contradicts its legitimate nature.
* **The "Telemetry Soup" in the Reformation:** Because open-source tools are so diverse, defenders are flooded with different artifacts. They must develop a deep **Ministry of Discernment** to pick out the "weird" signal from the massive noise of a decentralized environment.

---

### The Theological Frame: Freedom, Responsibility, and the Body of Christ

![The Theological Frame](https://www.nicenesecurity.com/assets/img/Command-and-Control/The_Theological_Frame.png)

1.  **Freedom and Responsibility:** Open source provides unprecedented freedom, but with it comes immense responsibility. You are the sole "custodian" of your specific agent variant. If it fails or crashes a system, you have no vendor to call; you must be a faithful steward of your own code.
2.  **The Body of Christ (Community):** Open-source development thrives on community—operators sharing code, knowledge, and bypasses. This reflects the principle that the community is stronger when they share their gifts for the benefit of the whole (1 Cor. 12).

### Summary of Part II
The Open-Source C2 Reformation has ushered in an era of unprecedented accessibility. It challenges Red Teams to be better stewards of their tools and Blue Teams to look past the surface and discern the true intent behind every process and connection.

---

> ### Looking Ahead: The Providence
>
> In **Part III**, we transition from the shared "Reformation" of the community into the focused realm of **Providence**. Here, we move beyond the public square and into the shadows of bespoke, in-house tradecraft. These are the "unwritten" tools—the surgical instruments crafted for specific missions where silence is the mandate. We will explore how the operator, acting in a state of high stewardship, navigates the deep internals of the machine, mindful that in the absence of public repositories and community signatures, the only witness to the integrity of the craft is the Creator Himself.
>
> ![Overview Part 3](https://www.nicenesecurity.com/assets/img/Command-and-Control/Overview_Part_3.png)

---
**AthanasiusXOR**

*Contra Mundum. Code Obscurum.*