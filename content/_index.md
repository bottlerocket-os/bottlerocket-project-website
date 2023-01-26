Bottlerocket is a Linux-based operating system optimized for hosting containers. It’s free and open-source software, developed in the open on [GitHub](https://github.com/bottlerocket-os). Bottlerocket is installed on the machine or instance where your containers themselves are running. It is specifically designed to work with your container orchestrator (like [Kubernetes](https://kubernetes.io/)) to automate the lifecycle of the containers running in your cluster. Bottlerocket runs in the cloud or in your datacenter.

Bottlerocket has three primary benefits goals: Minimal · Safe Updates · Security Focused.

![Diagram of cluster](/assets/homepage/bottlerocket-cluster.png)

*Bottlerocket is an operating system for the worker nodes in an orchestrated container cluster.*


## Minimal

Hosting containers doesn’t require much from an operating system and hosting containers is all Bottlerocket aims to do. Many of the packages, tools, interpreters, and dependencies installed by default in general purpose Linux distributions are simply not needed to only host containers. By excluding these extraneous pieces of software, your **operational and security overhead is reduced**. 

Bottlerocket manages complexity and requirements for different orchestrators, platforms, and architectures into specific builds for every compatible combination called **variants**. This ensures that your operating system is tailor made for that set of requirements.

[Image: Image.jpg]
*Bottlerocket variants assemble everything needed to run in a given environment. Pick the appropriate variant and nothing else is needed to join the cluster.*

Bottlerocket itself **does not have a shell**. It doesn’t need one. You can still interact with the system through privileged “host” containers (that do have shells). From host containers, you can explore the underlying operating system and even make changes to the running system’s settings via an API. 

![container with privileged access](/assets/homepage/priv-container.png)

*You can totally login to a Bottlerocket node, the shell you’re logging into is actually in a container with privileged access to the resources of the underlying operating system.* 


## Safe Updates

Bottlerocket is designed to be updatable but it **doesn’t have a package manager.** It doesn’t need one. Updates are delivered via an image that is downloaded to an specific partition. When you’re ready to update, let your orchestrator drain the node and then tell Bottlerocket to apply the update and reboot when ready. Bottlerocket will swap the partitions and boot with the new version atomically.

![Changeover occurs atomically at reboot](/assets/homepage/update.png)

*Bottlerocket uses multiple partitions to manage updates. Changeover occurs atomically at reboot.* 

Because system settings are accomplished through an API, Bottlerocket knows how to migrate these settings between versions. Should something go awry during an update, Bottlerocket has built in logic to revert to the previously working version with your settings intact. In many cases, this can be done automatically.

Bottlerocket updates can be managed manually or with the help of Bottlerocket’s orchestrator-specific tools: [Bottlerocket Update Operator (brupop)](https://github.com/bottlerocket-os/bottlerocket-update-operator) and the [ECS updater](https://github.com/bottlerocket-os/bottlerocket-ecs-updater).


## Security Focused

Being both minimal and updatable underlie important aspects of Bottlerocket’s focus on security. The use of variants delivered by an image means that there is **no requirement for a package registry or manager** that can mutate the system and introduce security issues. 

Bottlerocket’s **unique functionality is written in Rust** and a little bit of Golang. Both are compiled languages with built-in protection against [memory](https://hacks.mozilla.org/2019/01/fearless-security-memory-safety/) [safety](https://media.defense.gov/2022/Nov/10/2003112742/-1/-1/0/CSI_SOFTWARE_MEMORY_SAFETY.PDF) issues. Additionally, since Bottlerocket is delivered via images with all code pre-compiled, shells and interpreters are not needed, closing an undesirable pathway for execution of unverified code.

The root filesystem of Bottlerocket is immutable. [`dm-verity`](https://docs.kernel.org/admin-guide/device-mapper/verity.html) provides transparent integrity checking of the root filesystem and the kernel will restart if any changes to the underlying block device are detected. Additionally, Bottlerocket has an always-enabled, enforced, restrictive [SELinux](https://selinuxproject.org/page/Main_Page) policy for the mutable filesystem that helps prevent containers from executing dangerous operations, even when running as root.


![Changeover occurs atomically at reboot](/assets/homepage/selinux-dmverity.png)

*Bottlerocket has many layers of protection against unintended changes to the system.*


