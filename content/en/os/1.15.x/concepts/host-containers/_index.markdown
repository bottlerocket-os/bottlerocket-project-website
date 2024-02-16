+++
title = "Host Containers"
type = "docs"
description = "Special purpose, non-orchestrated containers for node management and administration" 
+++

Host containers are a special type of container you can use to manage and administer your Bottlerocket node.
These containers are non-orchestrated, which means Kubernetes or ECS are unaware of these containers and cannot directly manage their lifecycle.
Instead you manage the lifecycle of these containers by manipulating specific {{< ver-ref project="os" page="/api/settings/" >}}Bottlerocket settings{{< /ver-ref >}} with the {{< ver-ref project="os" page="/concepts/api-driven" >}}API{{< /ver-ref >}}.

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner >}}{{< components_diagram hide_admin_and_control=true >}}{{</ twocol_inner >}}
    {{% twocol_inner colsplit="7" %}} This diagram represents the components of the `aws-k8s-*` variant.
    Note the "Host Containers" in the upper left.
    {{%/ twocol_inner %}}
{{</ twocol >}}

## Built-in host containers

Depending on the variant, Bottlerocket has two standard host containers: the {{< ver-ref project="os" page="/install/quickstart/aws/host-containers#interacting-with-a-bottlerocket-node-through-host-containers" >}}control container{{< /ver-ref >}} and the {{< ver-ref project="os" page="/install/quickstart/aws/host-containers#exploring-the-admin-container" >}}admin container{{< /ver-ref >}}.
The control container provides a pathway to connect ([via SSM](https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent.html)) to and interact with the host as well as conveniently access the Bottlerocket API.
The control container also provides an entry point to the admin container.
The admin container allows you to more deeply interact with the host as it mounts the root filesystem and has elevated privileges.

The control and admin containers are not actually special: both are just host containers with specific privileges.
Case in point, you can disable (and {{< ver-ref project="os" page="/login/regaining-access" >}}re-enable{{</ ver-ref >}}) these containers as-needed and you can even fully replace the functionality of both the host and admins containers with your own host containers.

## Properties of host containers

Host containers have a number of different properties from orchestrated containers.

### Runtime

Bottlerocket has two parallel instances of `containerd`: one for your orchestrated workloads and one for host containers.

### API Access

All host containers automatically mount the API socket (`/run/api.sock`) and the API Client (`/usr/local/bin/apiclient`).
This allows you to run API commands and manipulate Bottlerocket settings from within the host containers without explicitly mounting these resources.
As a consequence, any user that can access a host container can change configurations which could effect the efficiency or stability of the node.

### Lifecycle & restarts

Host containers start and stop based on the value of their {{< setting-reference setting="settings.host-containers.<container>.enabled" >}}enabled{{</ setting-reference >}} setting.
If a host container exits, Bottlerocket automatically restarts the container after 45 seconds.

### Superpower

Host containers can have high levels of privilege.
See {{< setting-reference setting="settings.host-containers.<container>.superpowered" >}}{{</ setting-reference >}} for more details.

### Updates

Host containers do not update automatically.
Updates only occur when you update the {{< setting-reference setting="settings.host-containers.<container>.source" >}}{{</ setting-reference >}} or when an {{< ver-ref project="os" page="/update/methods/in-place" >}}in-place update{{</ ver-ref >}} occurs.

### User data

Distinct, but inspired by instance user data, host containers pass arbitrary[^1] base64-encoded data from the API into a file[^2].

### Persistent storage

All host containers have persistent storage that survive node reboots as well as container stop/start cycles[^2].

## Use Cases

When considering if you should use a host container, evaluate the specific properties of host containers and if you need to manage the lifecycle with your orchestrator.
Generally, you should try to solve your problem with an orchestrated container and only turn to a host container for low-level use-cases.

Examples:

- The control container is a host container because it needs to be available early to give you access to the OS.
- The admin container is a host container because it needs high levels of privilege and you may need it to debug when orchestration isn't working

## Also See

- `{{< ver-ref project="os" page="/api/settings/host-containers/" >}}host-containers{{</ ver-ref >}}` settings reference
- `{{< ver-ref project="os" page="/api/settings/bootstrap-containers/" >}}boostrap-containers{{</ ver-ref >}}` setting reference
- {{< ver-ref project="os" page="/concepts/bootstrap-containers/" >}}Bootstrap Containers{{</ ver-ref >}}

[^1]: The admin container has a special uses for user data. See the warning on {{< setting-reference setting="settings.host-containers.<container>.user-data" >}}{{</ setting-reference >}}
[^2]: Paths for persistent storage and user data (`<HOST_CONTAINER_NAME>` being the name of the host container):

    - `/.bottlerocket/host-containers/<HOST_CONTAINER_NAME>` and `/.bottlerocket/host-containers/<HOST_CONTAINER_NAME>/user-data` 
    - `/.bottlerocket/host-containers/current` and `/.bottlerocket/host-containers/current/user-data`
