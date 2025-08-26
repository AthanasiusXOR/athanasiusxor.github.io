---
title: From Decrees to DLLs - Part I - Payload Theology and the Order of Redemption
date: 2025-09-01
tags: [Red-Team, Doctrine, Decrees, Payloads]
categories: [Payload Development, Infrastructure, DLLs]
---
> ⚠️ The infrastructure, code, and methodologies described in this blog are designed **solely for lawful, educational, and ethical purposes**. This series is intended to help red team professionals, security researchers, and students build controlled environments for testing, training, and strengthening defensive postures.
>
> As those made in the image of God and called to walk in integrity, we affirm that knowledge must be governed by wisdom. The Apostle Paul reminds us, _“All things are lawful, but not all things are helpful”_ (1 Cor. 10:23). Accordingly, these tools are not to be used for harm, unauthorized access, or malicious activity of any kind.
>
> Let it be clear: **this work is to be conducted with a clear conscience before both God and man** (Acts 24:16). Those who weaponize such knowledge outside the bounds of legality and virtue not only violate human law, but grieve the moral law of the Creator Himself.
>
> _“Whatever you do, in word or deed, do everything in the name of the Lord Jesus...”_
>
> — **Colossians 3:17**

## Theological Baseline: God's Decrees and the Order of Redemption

In classic Reformed theology, the infralapsarian/supralapsarian debate addresses the *logical* (not the chronological) order of God's eternal decress--especially as they relate to **predestination**, **creation**, and **providence**. These are not ideal speculations, but reverent attempt to understand how God's sovereign will unfolds in harmony with His justice, mercy, and glory.

>
> "God's decrees must possess the character of God himself. There is no series of decrees in God, but simply one comprehensive plan, embracing all that comes to pass. The decrees are the foundation of His free knowledge or **scientia libera**. It is the knowledge of thigns as they are realized throughout history. While the ncessary knowledge of God logically preceds the decree. His free knowledge logically follows it.
>
> - *Louis Berkhof* **Systematic Theology**
>

The positions of infralapsarianism and supralapsarianism admit that the fall is included in the Divine Degrees and that preteritiion is an act of God's sovereign will. Supralapsarianism emphasizes the sovereignty of God, while infralapsarianism stresses the mercy and justice of God. Nevertheless, these positions affirm:

- God's **absolute sovereignty** over all things  
  *(cf. Isaiah 46:10; Ephesians 1:11)*
- The **necessity and certainty** of the fall as part of God's permissive decree  
  *(cf. Romans 11:32)*
- The **sufficiency and effectiveness** of Christ’s atonement for the elect  
  *(cf. John 10:14–15; Revelation 13:8)*

What differs between the two is the **logical sequencing** of these decrees—and therefore, *the theological emphasis*.

>
> “The key issue here is whetehr to consider the decree to elect and to reprobate logically before (supra-) or after (infra-) the decrees to create and to permit the fall. The counsel of God is to be understood as his eternal plan for all that exists or will happen in time. Scripture everywhere assumes that all is and comes to pass is a realization of God's thoguth and will and has its model and foundation in God's eternal counsel. God is not identified with His decrees; his self-knowledge is not exhuasted in creation, providence, and redemption.
> 
> - *Herman Bavinck*, **Reformed Dogmatics**
>

---

## Comparison Chart: Understanding God’s Decrees

At the heart of the **infralapsarian/supralapsarian** debate is a desire to understand how God’s eternal purposes unfold in His redemptive plan. These perspectives offer **distinct lenses** on how God logically (not chronologically) ordered His decrees concerning election, creation, the fall, and salvation.

| View                  | Logical Order of Decrees                                                                                       |
|-----------------------|-----------------------------------------------------------------------------------------------------------------|
| **Supralapsarianism** | 1. Election / Reprobation  <br> 2. Creation <br> 3. Fall permitted <br> 4. Redemption through Christ            |
| **Infralapsarianism** | 1. Creation <br> 2. Fall permitted <br> 3. Election of some to salvation <br> 4. Redemption through Christ       |

---

## Theological Distinctions

### Supralapsarianism

Supralapsarianism begins with God’s ultimate goal: to glorify Himself in both the salvation of the elect and the just condemnation of the reprobate. This position places **election and reprobation before the decree to create**, viewing all of redemptive history as the outworking of that eternal decision.

> "God, by an eternal and immutable decree, has determined both whom He would save and whom He would condemn — and this before the creation of the world."  
>
> — cf. *Francis Turretin*, **Institutes of Elenctic Theology**

> "God’s end must be first in His intention, and that end is the manifestation of His glory in election and reprobation."  
>
> — cf. *Jonathan Edwards*, *The End for Which God Created the World*

### Infralapsarianism

Infralapsarianism begins with God’s intention to **create humanity**, then permit the fall, and only afterward to elect some to salvation. This framework sees God’s redemptive decree as a **response to the fall**, emphasizing His mercy toward sinners. It aligns more closely with the **narrative flow of Scripture**, from Genesis to Revelation.

> “The fall is not the goal, but the backdrop against which the beauty of God’s grace shines forth.”  
>
> — cf. *Bavinck*, **Reformed Dogmatics**

> "God determined to permit the fall, and then out of the mass of fallen humanity, to choose some to life."  
>
> — cf. *Berkhof*, **Systematic Theology**

---

## Supporting Scriptures

### Election Before Creation

> *“He chose us in him before the foundation of the world, that we should be holy and blameless before him.”*  
>
> — *Ephesians 1:4*

> *“I will have mercy on whom I have mercy…”*  
>
> — *Romans 9:15*

### The Fall Within God’s Plan

> *“For God has consigned all to disobedience, that he may have mercy on all.”*  
>
> — *Romans 11:32*

> *“As in Adam all die, so also in Christ shall all be made alive.”*  
>
> — *1 Corinthians 15:22*

### Christ as Eternal Redeemer

> *“…the Lamb who was slain from the foundation of the world.”* 
> 
> — *Revelation 13:8*

> *“…foreknown before the foundation of the world…”*  
>
> — *1 Peter 1:20*

---

![God's Decrees](https://www.nicenesecurity.com/assets/img/From-Decrees-to-DLLs/Theological_Baseline_Gods_Decrees.png)

---

## Doctrinal Implications

![Infra_vs_Supra](https://www.nicenesecurity.com/assets/img/From-Decrees-to-DLLs/Infra_v_Supra.png)

## Summary: Why This Matters

These views do **not conflict** on the essentials of the gospel. Both affirm:

- God’s sovereign decree
- The necessity of the fall
- Christ as the only redeemer of the elect
- Redemption as planned from eternity

But the **difference in emphasis** shapes how we think about God's purposes. Is salvation the *starting point* (supralapsarianism), or God's *merciful response* to sin (infralapsarianism)?

So what does this have to do with Cybersecurity and Offensive Security Operations? Well, follow my logic below...

### If Supralapsarianism Is True...

Supralapsarianism starts with **the end goal**—namely, God’s glory through election and reprobation—as the *first* decree. Everything else, including creation and the fall, is subordinated to that aim.

- In red team terms, **payload development begins with intent**. You craft the tool, define its behavior, and engineer the shellcode in advance.
- You might not know *when* or *where* you’ll deploy it, but you're confident that the opportunity will eventually serve the objective.
- This model parallels an **offensive-first strategy**: the tool comes first, the exploit path is assumed.

> *“God’s end must be first in His intention.”*  
>
> — cf. *Edwards*, *The End for Which God Created the World*

This has a strong doxological pull: the logic flows from **glory to means**. Even human fallenness becomes a precondition to showcasing divine mercy and justice. Similarly, in sideloading, **vulnerabilities exist to serve the exploit**.

### If Infralapsarianism Is True...

Infralapsarianism begins with **creation**, followed by the **fall**, then the election of sinners unto salvation. The redemptive plan is thus a **response to rebellion**, not its cause.

- In red teaming, this looks like **recon-first payload building**. You examine the environment, identify trust boundaries, discover sideloadable DLLs, or exploitable COM objects—and then craft your payload accordingly.
- Your offensive tooling is **shaped by the architecture of the system**. You respond to weaknesses rather than dictate them.
- This is more **context-sensitive engineering**: discover the path first, then build the tool.

> *“The fall is not the goal, but the backdrop against which the beauty of God’s grace shines forth.”*  
>
> — cf. *Bavinck*, **Reformed Dogmatics**

This model emphasizes **mercy and adaptability**. The redemptive solution fits the fallen world. Likewise, the payload fits the trusted path—mimicking legitimacy, living within accepted bounds, and acting precisely at the point of misused trust.

---

## From Doctrine to Deployment: Applied Typology

The **theological lens** doesn’t stop at abstract categories. If infralapsarianism and supralapsarianism show us *how God orders His decrees*, then payload strategy reflects *how we order our actions*—in response to, or anticipation of, the environment.

That brings us into **applied typology** and back to the question I posed earlier: so what does this haave to dow ith Cybersecurity and Offensive Security Operations?

Typology is the theological principle that **God uses people, events, and structures as shadows** pointing to greater fulfillments in Christ. In offensive security, we too leverage the “types” already present—system binaries, registry keys, default paths—to create payloads that **fit into the story the system already tells**.

Next, we’ll examine how **DLL sideloading**, **DLL hijacking**, and **COM hijacking** become types—**exploits that mirror deeper truths** about proximity, trust, and the fall.

---

## Strategic Parallels in Payload Development

In both **theology** and **offensive security**, *what you build first* reveals your assumptions and priorities.

- **Supralapsarian developers** might write shellcode or implants first—before identifying how or where they’ll execute it.
- **Infralapsarian developers** start with analysis—understanding the target environment before shaping the payload.

This isn’t just metaphor. It reflects real-world tension in **red team strategy**:

| Paradigm              | Theological Framing        | Offensive Security Parallel                                           |
|----------------------|----------------------------|------------------------------------------------------------------------|
| Supralapsarian        | *Ends before means*         | Payload-first (build shellcode, then search for delivery vector)      |
| Infralapsarian        | *Means before ends*         | Recon-first (understand trust chains, then tailor the payload)        |

This mirrors the difference between **building toward an outcome** (e.g., executing shellcode at all costs) and **designing for real-world context** (e.g., stealth, trust, and execution paths in memory).

![Two Paths - One Payload](https://www.nicenesecurity.com/assets/img/From-Decrees-to-DLLs/TwoPaths_OnePayload.png)

---

## Preview: Where the Trust Gets Abused

That’s where our triad of attack techniques comes in:

- **[DLL Sideloading](https://d3fend.mitre.org/offensive-technique/attack/T1574.002/)** – Malicious DLL placed in a trusted path, mimicking legitimate behavior.
- **[DLL Hijacking](https://attack.mitre.org/techniques/T1574/001/)** – An application loads a malicious DLL due to path search order or missing dependencies.
- **[COM Hijacking](https://specterops.io/blog/2025/05/28/revisiting-com-hijacking/)** – Registry-level abuse to redirect object creation to malicious DLLs.

Each of these reflects a kind of **perversion of trust**, not unlike the theological story of the Fall—where authority structures were subverted, not shattered.

> "Sin never creates. It only corrupts. It twists what God made good and turns it toward self and rebellion."  
>
> — cf. *Edwards*

Therefore, in **Part II**, we will take these theological ideas into the **technical trenches**, exploring how DLL sideloading, hijacking, and COM hijacking exploit trust structures already in place—just like the serpent did in the Garden.

We'll also unpack typology between the Fall of Adam and modern-day payload delivery, showing how deception and proximity—not brute force—create devastating breaches.

> *“You will not surely die…”* 
>
> — *Genesis 3:4*

That’s the voice of both heresy and exploitation.

## References

- https://d3fend.mitre.org/offensive-technique/attack/T1574.002/

https://attack.mitre.org/techniques/T1574/001/

https://specterops.io/blog/2025/05/28/revisiting-com-hijacking/
