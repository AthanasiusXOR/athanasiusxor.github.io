---
title: From Decrees to DLLs - Part II - Typology, Trust, and Payloads
date: 2025-09-15
tags: [Red-Team, Doctrine, Decrees, Payloads]
categories: [Payload Development, Infrastructure, DLLs]
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

>
> *"You will not surely die...*"
>
> - *Genesis 3:4*

That was the **First exploit**. It was not brute force, or **Eternal Blue**. It was deception, using a legitimate structure-misusing the trust built into the system. And that is the heart of **DLL Sideloading**, **DLL Hijacking**, and **COM Hijacking**.

---

## Real-World Payload History

Now that we have laid the theological groundwork (see [Part I](https://www.nicenesecurity.com/posts/From-Decrees-to-DLLs-Part-I/)), it is time to examine how payload development plays out in the field--particularly where **trust is abused**. 

Here are three techniques red teamers use to inject malicious payloads via **legitimate mechanisms**. 

### 1. [DLL Sideloading](https://attack.mitre.org/techniques/T1574/001/)

**Sideloading** occurs when a signed, trusted executable loads a malicious DLL placed in its working directory *in place of* an expected one. The logic? The application trusts what’s nearby.

![DLL Sideloading](https://www.nicenesecurity.com/assets/img/From-Decrees-to-DLLs/DLLSideloading.png)

#### A Case Study: Logitech `ffmpeg.dll`

We took `lghub.exe`, a Logitech-signed binary that loads `ffmpeg.dll` from its current directory. By renaming the legitimate `ffmpeg.dll` to `ffmpeg1.dll` and placing our own proxy DLL in its place, we were able to:

- Forward all **52 exports** to `ffmpeg1.dll`
- Load and decode **XOR-encrypted shellcode** from `logitech_ips.txt`
- Execute the payload in-memory using `NtAllocateVirtualMemory` + `NtCreateThreadEx`

**Typology**: Like Eve trusting the serpent's words because of his proximity and presence in Eden, the executable *trusts* the DLL because of its location. But proximity ≠ purity.

> “Proximity to the sacred does not guarantee obedience to the holy.”  
>
> — cf. *John Frame*, **Doctrine of the Christian Life**

The sideloaded DLL would still require additional refinement to ensure it could effectively evade modern endpoint detection and response (EDR) solutions. While the technical framework and interpretive methdologies for understanding DLL sideloading are well established, the technique itself must be approached with caution. Like any advanced security research method, it carries both significant potential and inherent risk. For this reason, DLL sideloading should be applied judiciously, with an awareness of its implications, limitations, and the ethical context in which it is used. 

---

### 2. [DLL Hijacking](https://d3fend.mitre.org/offensive-technique/attack/T1574.002/)

**Hijacking** relies on a search path vulnerability. When an application attempts to load a DLL that’s **missing or improperly resolved**, the attacker plants a malicious version in a directory the system searches *before* finding the real one.

![DLL Hijacking](https://www.nicenesecurity.com/assets/img/From-Decrees-to-DLLs/DLLHijacking.png)

#### Case Study: WorkspaceONE `selfservice.dll`

We replaced `SelfServicePlugin.dll`, loaded by `SelfService.exe`, with a **malicious copy** that:

- Retained required exports (to avoid crashing)
- Loaded shellcode dynamically from a `.txt` file formatted as **IPv4 strings**
- Used stealthy syscalls for injection
- Triggered via legitimate app start-up

**Typology**: Hijacking resembles theological heresy—an imposter claiming the name of orthodoxy, loaded by default unless corrected by explicit truth. Just as Adam and Eve followed a *misplaced dependency*, hijacked binaries follow the wrong path unless told otherwise.

> “Sin hijacks what was good, not by destroying it—but by redirecting it.”  
>
> — cf. *Stephen Wellum*, **Systematic Theology**

---

### 3. COM Hijacking

**COM hijacking** abuses the Windows Registry to redirect the loading of COM objects to **malicious DLLs**. It’s stealthy, persistent, and rarely logged.

- Attacker drops a DLL in a user-writable location
- Modifies `HKCU\Software\Classes\CLSID\{GUID}\InprocServer32` to point to the DLL
- The next time the CLSID is used, the malicious DLL is loaded

Antero Guy, with [SpecterOps](https://specterops.io/blog/2025/05/28/revisiting-com-hijacking/), revisited COM Hijacking in there recent blog, which does a great job of walking through a real-world proof of concept.

**Typology**: This is **system-level subversion**, the equivalent of twisting the interpretive lens (hermeneutic) through which truth is processed. The registry is the *canon*, and the attacker rewrites the reference.

> “Once you corrupt the source of authority, everything downstream will follow.”  
>
> —cf. *Herman Bavinck*, **Reformed Dogmatics**

---

## Typology: From Eden to Endpoint

Let’s connect it all:

| Exploit Technique    | Typological Parallel from the Fall          | Theological Note                                             |
|----------------------|---------------------------------------------|--------------------------------------------------------------|
| **DLL Sideloading**  | Serpent close to Eve in Eden                | Proximity ≠ legitimacy                                       |
| **DLL Hijacking**    | Misplaced trust in a lookalike message      | False teachers *seem* right — until examined                 |
| **COM Hijacking**    | Registry redefinition (corrupted authority) | Subversion of interpretive framework (like modern liberalism)|

In **Genesis 3**, the serpent does not break into the garden. He doesn’t force Eve. He simply inserts a payload of doubt into an already-trusted environment.

---
## Inversion and Redemption

But here’s the beauty of biblical theology: God doesn’t just patch the vulnerability. He rewrites the system.

- Where the **first Adam** failed, the **second Adam** obeyed (cf. *Romans 5:19*)
- Where trust was hijacked, **truth was revealed**
- Where proximity to deception led to death, **union with Christ** now leads to life

And so the question for the red teamer becomes: **Are you reinforcing deception, or exposing it?** Are your tools designed to *mirror corruption*, or to help the defenders see how trust can be **redeemed**?

> “All theology must lead to doxology. All offensive security must lead to defense.”  

---

## Practical Warning

Red teamers who play with trust must not become its abusers. The **more you understand trust boundaries**, the more responsibility you bear in not repeating the Fall.

> *"To whom much is given, much will be required."* 
>
> — *Luke 12:48*

---

## Conclusion

In offensive security, the order of operations—whether you begin with payload development or reconnaissance—reveals what you assume about the engagement. If you start with payloads, you’re assuming the environment will bend to your design; you believe you can engineer an implant or loader in advance that will find its place. That’s almost a supralapsarian stance—the end (compromise) is fixed in your design before you even reckon with the environment.

If you start with recon, however, you’re conceding that the target environment sets the terms. You gather intelligence, map defenses, and adapt your tools to fit what is revealed. That’s closer to an infralapsarian stance—the “decree” of attack follows the observed “fallenness” of the environment. In both cases, the order says something about your worldview as an operator.

The same is true of what you choose to abuse.

- **Proximity** (physical access, trusted networks) assumes broken boundaries—like Adam and Eve reaching beyond their limits.
- **Legitimacy** (credentials, certificates, tokens) exploits trust itself, which recalls how sin often masquerades as righteousness.
- **Structure** (APIs, DLLs, process hierarchies) manipulates the created order, twisting what was meant for good into a vehicle of corruption.

Each attack vector mirrors some aspect of the Fall: proximity perverts nearness, legitimacy corrupts authority, and structure distorts design.

So, the way you frame your red team operations—what comes first, and what you exploit—always says something about your hermeneutic of the environment. Just as theologians wrestle with whether God’s decrees flow from His will or from His foreknowledge of sin, so too red teamers reveal their assumptions in the sequence and substance of their operations.

---

> Until then, build precisely. Think theologically. And never trust a DLL by its directory alone.

---

**Athanasius of Alexandria**  
**Contra Mundum. Code Obscurum.**

> To all who operate in shadows not of deception, but of discernment — we forge tools, but we answer to truth.  
>
>The mission is doctrinal, not merely digital. The payload is not only code, but conviction.  


#### Recommended Reading | References

- [MITRE](https://d3fend.mitre.org/offensive-technique/attack/T1574.002/) article on Sideloading.

- [MITRE](https://attack.mitre.org/techniques/T1574/001/) article on DLL Process Inection.

- [SpecterOps](https://specterops.io/blog/2025/05/28/revisiting-com-hijacking/) article by Antero Guy about a real-world POC of COM Hijacking.
