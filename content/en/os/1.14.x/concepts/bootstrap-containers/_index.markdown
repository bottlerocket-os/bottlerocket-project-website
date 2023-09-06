+++
title = "Bootstrap Containers"
type = "docs"
description = "Setting up the host with containers that start during boot." 
+++

Bootstrap containers are a form of {{< ver-ref project="os" page="/concepts/components" >}}host container{{< /ver-ref >}} that you can use to run critical software before the node connects to an orchestrator.
They give you subsantial power to configure and modify the system in ways that would otherwise be [difficult or impossible](#use-cases).

## Lifecycle

When you define a bootstrap container using user-data or the Bottlerocket API, the following sequence occurs on next boot:

- [`systemd`](https://systemd.io/) starts all of the bootstrap containers concurrently,
- the boot process pauses while the bootstrap containers start, run, and exit,
- any bootstrap container configured to `{{< ver-ref project="os" page="/api/settings/bootstrap-containers#name_mode">}}mode=once{{< /ver-ref >}}` will change to `{{< ver-ref project="os" page="/api/settings/bootstrap-containers#name_mode">}}mode=off{{< /ver-ref >}}` once complete,
- if bootstrap container are set to `{{< ver-ref project="os" page="/api/settings/bootstrap-containers#name_essential">}}essential=true{{< /ver-ref >}}` and one of those containers exits with a non-zero exit code, the boot process halts,
- unless stopped in the previous step, the boot process continues by loading the orchestrator agent ({{< ver-ref project="os" page="/concepts/components#container-and-orchestrator-support">}}`kubelet` on `*-k8s-*`{{< /ver-ref >}} variants or the {{< ver-ref project="os" page="/concepts/components#ecs-variants">}}ECS agent on `*-ecs-*`{{< /ver-ref >}} variants).

### Examples

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner >}}
        example 1
    {{</ twocol_inner >}}
    {{% twocol_inner colsplit="7"%}}
This example shows four containers (`a`,`b`,`c`, and `d`) starting.
The start order of these containers is not sequential.
Container `b` runs the longest and the next stage of the boot does not proceed until it completes.
    {{%/ twocol_inner %}}
{{</ twocol >}}

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner >}}
        example 1
    {{</ twocol_inner >}}
    {{% twocol_inner colsplit="7"%}}
This example is the same as the previous one except container `b` is configured with {{< ver-ref project="os" page="/api/settings/bootstrap-containers#name_essential">}}`essential=true`{{< /ver-ref >}}.
Container `b` exits with a non-zero exit code and consquently the boot halts.
    {{%/ twocol_inner %}}
{{</ twocol >}}


{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner >}}
        example 1
    {{</ twocol_inner >}}
    {{% twocol_inner colsplit="7"%}}
This example is the same as the first except container `d` is configured with {{< ver-ref project="os" page="/api/settings/bootstrap-containers#name_mode">}}`mode=once`{{< /ver-ref >}}.
After all the bootstrap containers complete, Bottlerocket updates container `d`'s `mode` to `off`. 
    {{%/ twocol_inner %}}
{{</ twocol >}}


### Considerations

As a consequence of this lifecycle, you should keep a few things in mind when using bootstrap containers:

1. Bootstrap containers should be short-running and cleanly exit when complete otherwise your node will hang.
2. Since `systemd` starts all the bootstrap containers concurrently, you cannot rely on a deterministic starting order.
3. Bootstrap containers do not have access to the container orchestrator nor the rest of the cluster.



## Capabilities and permissions

Bootstrap containers lie somewhat between default host containers and `superpowered` host container permissions.
They have access to the underlying host filesystem at `/.bottlerocket/` which contains the root filesystem (`/.bottlerocket/rootfs`).
Additionally, bootstrap containers run with the {{< ver-ref project="os" page="/api/settings/oci-defaults#capabilities_sys-admin" >}}CAP_SYS_ADMIN capability{{< /ver-ref >}}, allowing for the creation of files, directories, and mounts accessible to the host (however the root filesystem remains {{< ver-ref project="os" page="/concepts/restricted-filesystem#immutable-filesystem" >}}immutable{{</ ver-ref>}}).
You cannot elevate the permissions of bootstrap containers.

## Use cases

Bootstrap containers have a variety of uses.

1. Configure large setting values.
On many platforms there are [limits to the size of user-data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-add-user-data.html) but you can use a bootstrap container to pass large values into `apiclient`.
2. Conditionally halt boot.
You can perform checks or evaluation of the system in a {{< ver-ref project="os" page="/api/settings/bootstrap-containers#name_essential" >}}bootstrap container with `essential` set to `true`{{< /ver-ref >}}.
3. Apply settings you do not want to store in plaintext.
In cases where you need to pass values that you would not want to store in plain-text on external systems (such as credentials), you can instead use a bootstrap container that sets the values via `apiclient`.
4. Configure ephemeral disks. Since [bootstrap containers have access to `/.bottlerocket/`](#capabilities-and-permissions) and all bootstrap or `superpowered` host containers share this bind mount, you can configure ephemeral disks attached to your host in a bootstrap container and use it elsewhere.
