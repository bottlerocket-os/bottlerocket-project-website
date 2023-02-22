## Security Focused

Being both minimal and updatable underlie important aspects of Bottlerocket’s focus on security.
The use of variants delivered by an image means that there is **no requirement for a package registry or manager** that can mutate the system and introduce security issues.

Bottlerocket’s **unique functionality is written in Rust** and a little bit of Golang.
Both are compiled languages with built-in protection against [memory](https://hacks.mozilla.org/2019/01/fearless-security-memory-safety/) [safety](https://media.defense.gov/2022/Nov/10/2003112742/-1/-1/0/CSI_SOFTWARE_MEMORY_SAFETY.PDF) issues.
Additionally, since Bottlerocket is delivered via images with all code pre-compiled, shells and interpreters are not needed, closing an undesirable pathway for execution of unverified code.

The root filesystem of Bottlerocket is immutable.
[`dm-verity`](https://docs.kernel.org/admin-guide/device-mapper/verity.html) provides transparent integrity checking of the root filesystem and the kernel will restart if any changes to the underlying block device are detected.
Additionally, Bottlerocket has an always-enabled, enforced, restrictive [SELinux](https://selinuxproject.org/page/Main_Page) policy for the mutable filesystem that helps prevent containers from executing dangerous operations, even when running as root.

{{< twocolfigure  alt="Diagram of storage security"  caption="Bottlerocket has many layers of protection against unintended changes to the system." >}}
    {{% readfile "includes/homepage/dm-verity-selinux.svg" %}}
{{</ twocolfigure>}}
