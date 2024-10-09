+++
title = "Bootstrap Commands"
type = "docs"
description = "Setting up the host with Bottlerocket API commands during boot."
+++

Bootstrap commands are a way to configure and modify a Bottlerocket instance using the Bottlerocket API at boot time. They run prior to the Bootstrap Containers.

## Lifecycle

When you define a bootstrap command using user-data or the Bottlerocket API, the following sequence occurs on next boot:

- [`systemd`](https://systemd.io/) runs all the bootstrap commands in lexicographical order of their names. Each Bottlerocket API command inside a bootstrap-command will be run serially in the declared order.
- `systemd` will not move to the next [target](https://www.freedesktop.org/software/systemd/man/systemd.target.html) until all of the bootstrap commands start, run and exit.
- any bootstrap command configured with `mode=once` will change to `mode=off` once complete.
- any bootstrap command set to `essential=true` that exits with a non-zero exit code halts the boot process.

### Examples

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner colsplit="7" >}}
        {{< bootstrap_commands_diagram example=1 >}}
    {{</ twocol_inner >}}
    {{% twocol_inner %}}
This example shows four bootstrap commands with names (`001-cmd`,`002-cmd`,`003-cmd`, and `004-cmd`) starting.
The start order of these commands is in lexicographical order of their names.
The next stage of the boot does not proceed until the last bootstrap command completes.
    {{%/ twocol_inner %}}
{{</ twocol >}}

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner  colsplit="7" >}}
        {{< bootstrap_commands_diagram example=2 >}}
    {{</ twocol_inner >}}
    {{% twocol_inner %}}
This example is the same as the previous one except bootstrap command `003-cmd` is configured with {{< ver-ref project="os" page="/api/settings/bootstrap-commands#name_essential">}}`essential=true`{{< /ver-ref >}}.
Bootstrap command `003-cmd` exits with a non-zero exit code and consequently the boot halts. As a result, `004-cmd` isn't run at all.
    {{%/ twocol_inner %}}
{{</ twocol >}}

{{< twocol
    containerclass="td-max-width-on-larger-screens docs-figure"
    rowclass="docs-figure" >}}
    {{< twocol_inner  colsplit="7" >}}
        {{< bootstrap_commands_diagram example=3 >}}
    {{</ twocol_inner >}}
    {{% twocol_inner %}}
This example is the same as the first except bootstrap command `004-cmd` is configured with {{< ver-ref project="os" page="/api/settings/bootstrap-commands#name_mode">}}`mode=once`{{< /ver-ref >}}.
After `004-cmd` finishes, Bottlerocket (via a `systemd` unit) updates bootstrap command `004-cmd`'s `mode` to `off`.
    {{%/ twocol_inner %}}
{{</ twocol >}}

### Considerations

As a consequence of this lifecycle, you should keep a few things in mind when using bootstrap commands:

1. Bootstrap commands can only run Bottlerocket API commands (specifically commands that start with apiclient). The exception to this rule is that it can’t run `apiclient exec` commands because host containers aren’t spawned during early boot.
2. Attempting to run `apiclient reboot` in a bootstrap command with `mode=always` will cause the node to reboot endlessly.
3. `apiclient reboot` in a bootstrap command with `mode=once` will hold off the reboot until the completion of all bootstrap commands.
4. Due to serial nature of bootstrap commands, they should be short-running to reduce overhead on boot times.

## Use cases

Bootstrap commands have a variety of uses. The following examples give the toml configuration to achieve the task.

### Configure ephemeral disks

**In k8s host**

```
[settings.bootstrap-commands.k8s-ephemeral-storage]
commands = [
    ["apiclient", "ephemeral-storage", "init"],
    ["apiclient", "ephemeral-storage" ,"bind", "--dirs", "/var/lib/containerd", "/var/lib/kubelet", "/var/log/pods"]
]
essential = true
mode = "always"
```

**In ecs host**

```
[settings.bootstrap-commands.ecs-ephemeral-storage]
commands = [
    ["apiclient", "ephemeral-storage", "init"],
    ["apiclient", "ephemeral-storage" ,"bind", "--dirs", "/var/lib/containerd", "/var/lib/docker", "/var/log/ecs"]
]
essential = true
mode = "always"
```

### Running the CIS reports

**Bottlerocket CIS Benchmark**

```
[settings.bootstrap-commands.bottlerocket-cis-benchmark]
commands = [["apiclient", "report", "cis", "-l", "2"]]
essential = true
mode = "always"
```

**Kubernetes CIS Benchmark**

```
[settings.bootstrap-commands.kubernetes-cis-benchmark]
commands = [["apiclient", "report", "cis-k8s", "-l", "2"]]
essential = true
mode = "always"
```

### Checking and Applying Update

```
[settings.bootstrap-commands.kubernetes-cis-benchmark]
commands = [["apiclient", "update", "apply", "--check", "--reboot"]]
essential = true
mode = "always"
```

## Also see
- {{< ver-ref project="os" page="/api/settings/bootstrap-commands">}} bootstrap-commands in the API Setting Reference{{< /ver-ref >}}

{{< on-github >}}
