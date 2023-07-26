## Minimal

Hosting containers doesn’t require much from an operating system and hosting containers is all Bottlerocket aims to do.
Many of the packages, tools, interpreters, and dependencies installed by default in general purpose Linux distributions are simply not needed to only host containers.
By excluding these extraneous pieces of software, your **operational and security overhead is reduced**.

Bottlerocket manages complexity and requirements for different orchestrators, platforms, and architectures into specific builds for every compatible combination called **variants**.
This ensures that your operating system is tailor made for that set of requirements.

{{< stackedfigure  alt="Diagram of variants"  caption="Bottlerocket variants assemble everything needed to run in a given environment. Pick the appropriate variant and nothing else is needed to join the cluster." >}}{{< diagram_variants >}}
{{</ stackedfigure>}}

Bottlerocket itself **does not have a shell**.
It doesn’t need one.
You can still interact with the system through privileged “host” containers (that do have shells).
From host containers, you can explore the underlying operating system and even make changes to the running system’s settings via an API.

{{< twocolfigure  colsplit="7" caption="You can totally login to a Bottlerocket node. The shell you’re logging into is actually in a container with privileged access to the resources of the underlying operating system." >}}
    {{% readfile "includes/homepage/priv-container.svg" %}}
{{</ twocolfigure>}}
