+++
title = "Chain of Trust"
type = "docs"
description = "Bottlerocket's cryptographic validation mechansims"
+++

Container hosts are particularly sensitive, with nearly unfettered access to your workloads, secrets, storage, and network.
Consequently, ensuring that only your desired code runs on the host is paramount. Bottlerocket’s chain of trust provides cryptographic verification of all parts of the boot sequence through to your containers starting.
Effectively, this means that every step verifies the next step in the sequence and any verification failure will immediately prevent any further progress.

Starting from Bottlerocket 1.15.0 with Kubernetes 1.28 or ECS 2 variants (or newer), Secure Boot is enabled by default, where supported by firmware.

## Boot Sequence

{{% readfile "/includes/os/1.15.x/secure-boot.svg" %}}

The chain of trust starts prior to booting Bottlerocket.
Modern, server-class machines initialize by loading firmware that conforms to the [UEFI specification](https://en.wikipedia.org/wiki/UEFI).
In the most basic configuration, the firmware hands off control of the machine to the OS or bootloader.
However, UEFI optionally implements Secure Boot, which is a mechanism that prevents hand off to unsigned software. Bottlerocket uses Secure Boot by default.

To start, the firmware retrieves the Bottlerocket certificate stored in the system’s NVRAM and uses it to verify that the first-stage bootloader, [shim](https://github.com/rhboot/shim), is correctly signed.

{{% alert title="Note" color="success" %}}
Many operating systems use a version of shim signed by the Microsoft 3rd Party UEFI CA certificate. Bottlerocket does not use this certificate.
Instead, Bottlerocket uses a self-signed certificate intended to allow you to focus your machine’s trust only to your specified OS (in this case, Bottlerocket).
From Microsoft’s article [“Secure the Windows boot process”](https://learn.microsoft.com/en-us/windows/security/operating-system-security/system-security/secure-the-windows-10-boot-process):

*“Since the Microsoft 3rd Party UEFI CA certificate signs the bootloaders for all Linux distributions, trusting the Microsoft 3rd Party UEFI CA signature in the UEFI database increases the attack surface of systems. A customer who intended to only trust and boot a single Linux distribution will trust all distributions - much more than their desired configuration.”*
{{% /alert %}}

Shim has access to certs stored in NVRAM. These certs are needed to verify the signed binary for GNU GRUB, the next step in the boot process.
GRUB verifies the signature of its configuration file, `grub.cfg`, then grub calls into shim to verify the kernel.
The GRUB configuration also contains the dm-verity root hash for the immutable root filesystem. GRUB hands off to the now-verified Linux kernel which can mount the root filesystem using the dm-verity root hash.

If any verification fails during the above process, the boot sequence will cease.
After the boot process, dm-verity will detect any changes to the block device underlying the root filesystem and trigger a reboot of the machine.

## Requirements

This chain of trust relies on Secure Boot enabled firmware. Secure Boot has some prerequisites which are primarily relevant on `metal` variants:

1. UEFI firmware
2. Firmware Secure Boot feature enabled; Compatibility Support Module and/or legacy bios emulation disabled
3. The machine’s NVRAM must contain Bottlerocket’s "db" certificate, which is used to sign shim. The Bottlerocket EFI partition includes this certificate in both PEM and DER formats.

Verifying these requirements varies by hardware vendor and may involve making edits on your hardware’s firmware setup menu.

On `aws-*` variants , any instance based with a Xen-based hypervisor (generation 4 and below) use a legacy BIOS mode and consequently cannot use Secure Boot.

## Related

- [FAQ: How do I disable Secure Boot?](/en/faq/#4_3)
- [Concept: Restricted filesystem](../restricted-filesystem/)
