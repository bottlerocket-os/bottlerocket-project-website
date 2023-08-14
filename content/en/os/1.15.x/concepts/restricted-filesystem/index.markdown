+++
title = "Restricted Filesystem"
type = "docs"
description = "Protections to the host filesystem" 
+++

Bottlerocket is a container host operating system.
Most containerized workloads need little, if any access to the underlying host filesystem.
This, paired with image-based updates, means that much of the filesystem can be immutable.
Still, there are some resources like logs, container images, and configuration files that do need to be mutable for a practically operable system.
Bottlerocket splits the difference by having some storage that is immutable and some that is mutable, using different protection mechanisms for each filesystem.
Additionally, some mutable storage in Bottlerocket only exists ephemerally and any changes will not survive a reboot.

## Immutable Filesystem

Bottlerocket’s root filesystem is a dm-verity device: all dm-verity devices are read-only.
In context of Bottlerocket, it means that modification of the root filesystem is not possible by userspace processes.

### Block-level protection

dm-verity also protects the root filesystem from unintended changes at the block level: it uses a hash tree to provide transparent integrity checking.
At a high level, dm-verity works like this:

* A hash function calculates a cryptographic digest for each physical block,
* The same hash function calculates the combination of all the digests from the previous step,
* This repeats until a single digest remains (the “root block”).

dm-verity saves the root block digest and compares it after every write with the new root block digest.

{{% readfile "/includes/os/1.13.x/dm-verity-without-change.markdown" %}}

If a physical block changes, this causes each subsequent layer to produce a different digest resulting in a different root block digest.

{{% readfile "/includes/os/1.13.x/dm-verity-with-change.markdown" %}}

The kernel will trigger a reboot if the root block digest changes.

## Mutable Filesystem

An immutable filesystem is not practical for many resources in Bottlerocket.
Files in the non-root filesystem have a variety of different accessibility requirements.
Bottlerocket uses SELinux policies to protect files in the non-root filesystem.
Unlike the immutable filesystem, SELinux allows for granular labels applied at a per-file basis, so protections vary based on the requirements of each resource.

For example, Kubelet can write logs to  `/var/log/containers`  and the Bottlerocket API server can change `/etc/motd` because of specific SELinux labels.

SELinux policies in Bottlerocket are set to enforcing, meaning they both log attempts and prevent changes to particular resources.
Also unlike the immutable filesystem, a sufficiently privileged user can alter the SELinux labels of a file or resource.

## Ephemeral Storage

Part of the mutable filesystem, `/etc` , does not persist through a reboot.
The use of ephemeral storage in this area provides  two advantages:

* it creates more reliable pathways for configuration changes (through the API and/or with special containers specifications like [CNI](https://github.com/containernetworking/cni) or [CSI](https://github.com/container-storage-interface/spec)),
* it makes it more difficult for attackers to make changes that persist.
