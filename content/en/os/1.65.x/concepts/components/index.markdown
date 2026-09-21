+++
title = "Components"
type = "docs"
description = "The pieces that constitute Bottlerocket"
+++

The components of Bottlerocket differ substantially from most Linux distributions. By providing ready-to-run images, some software typically considered as workloads of an operating system are integral to Bottlerocket.

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner >}}{{< components_diagram >}}{{</ twocol_inner >}}
    {{% twocol_inner colsplit="7" %}} This diagram represents the components of the `aws-k8s-*` variant. Subsequent sections will dissect and explain this variant. {{%/ twocol_inner %}}
{{</ twocol >}}

### Foundation

{{< twocol containerclass="td-max-width-on-larger-screens docs-figure" rowclass="docs-figure">}}
    {{< twocol_inner >}}
        {{< components_diagram
            disable_kubelet=true
            disable_containerd_left=true
            disable_containerd_right=true
            disable_pods=true
            disable_host_containers=true
            disable_systemd=true
             >}}
     {{</ twocol_inner >}}
     {{% twocol_inner colsplit="7" %}}
The Linux kernel provides the foundation of Bottlerocket. The kernel (major+minor) version may vary between variants, but does not change on update.
     {{%/ twocol_inner %}}
{{</ twocol >}}

### System Services

{{< twocol containerclass="td-max-width-on-larger-screens docs-figure" rowclass="docs-figure">}}
    {{< twocol_inner >}}
        {{< components_diagram
            disable_kubelet=true
            disable_containerd_left=true
            disable_containerd_right=true
            disable_pods=true
            disable_host_containers=true
            disable_kernel=true
             >}}
     {{</ twocol_inner >}}
     {{% twocol_inner colsplit="7" %}}
systemd serves as the initialization and service management layer. systemd unifies a broad, modern, widely-used set of APIs that Bottlerocket can build atop in a variety of contexts.
     {{%/ twocol_inner %}}
{{</ twocol >}}

### Container and Orchestrator Support

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
        {{< twocol_inner >}}
            {{< components_diagram
                disable_pods=true
                disable_host_containers=true
                disable_kernel=true
                disable_systemd=true
                >}}
        {{</ twocol_inner >}}
        {{% twocol_inner  colsplit="7" %}}
Bottlerocket runs two instances of the container runtime, containerd. Containers used for operational and administrative purposes have a devoted containerd instance, whilst orchestrator-managed workloads have a separate containerd instance. 

On Kubernetes variants, Bottlerocket runs Kubelet to communicate with the Kubernetes control plane and orchestrate container lifecycles.
        {{%/ twocol_inner %}}
{{</ twocol >}}

### Application Workloads

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner >}}
    {{< components_diagram
        disable_host_containers=true
        disable_kernel=true
        disable_systemd=true
        disable_containerd_left=true
        disable_containerd_right=true
        disable_kubelet=true
    >}}
    {{</ twocol_inner >}}
    {{% twocol_inner colsplit="7"%}}
Bottlerocket defers workload management to the orchestrator. While Bottlerocket is a distinctive operating system, the differences are mostly transparent to your application workloads. If your workload requires specific host-level interactions, accommodations go through the Bottlerocket Settings API in addition to typical patterns of mounted directories and container privileges.
    {{%/ twocol_inner %}}
{{</ twocol >}}

### Operational and Administrative Workloads

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner >}}
     {{< components_diagram
        disable_kernel=true
        disable_systemd=true
        disable_containerd_left=true
        disable_containerd_right=true
        disable_kubelet=true
        disable_pods=true
    >}}
    {{</ twocol_inner >}}
    {{% twocol_inner colsplit="7"%}}
“Host Containers” are containers specifically used to maintain, operate, or administer the node. Host containers provide a secondary method to manipulate and administer the operating system even if the orchestrator agent is non-responsive or exhausted of resources.

There are two host containers that are published for use with Bottlerocket: the control container and the admin container.
The control container is on by default.
It is pre-configured to be able to use the Bottlerocket API and can be accessed by SSM.
The admin container is off by default and has elevated privileges for system exploration and debugging.
Furthermore, any container can be [run as a host container](https://github.com/bottlerocket-os/bottlerocket#custom-host-containers), and any number of host containers can run.
    {{%/ twocol_inner %}}
{{</ twocol >}}

## Differences between variants

### ECS Variants

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner >}}
        {{< components_diagram
            show_ecs="true"
            kubelet_label="docker"
            pods_label="Tasks"
        >}}
    {{</ twocol_inner >}}
    {{% twocol_inner colsplit="7"%}}

Bottlerocket ECS variants function in roughly the same way but differ subtly in components. Instead of Kubelet, ECS variants use the ecs-agent and Docker daemon. The ecs-agent communicates with the ECS control plane but Docker interposes between the agent and the container runtime.

    {{%/ twocol_inner %}}
{{</ twocol >}}

### On-premise Variants (Baremetal & VMware)

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner >}}
        {{< components_diagram 
            disable_control_container="true"
        >}}
    {{</ twocol_inner >}}
    {{% twocol_inner colsplit="7"%}}

Variants designed to run on-premises have different access constraints. The control container with SSM is available, but disabled by default. As with the other variants, Bottlerocket does not start with an enabled admin container, however some solutions may enable it for an easier first-boot access path.

    {{%/ twocol_inner %}}
{{</ twocol >}}

{{< on-github >}}
