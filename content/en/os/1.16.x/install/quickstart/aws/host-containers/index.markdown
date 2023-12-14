+++
title="Host Containers"
type="docs"
description="How to interact with a Bottlerocket node through Host Containers"
+++

{{< hide-and-re-highlight-menu link_url="/en/os/%s/install/quickstart/" depad="true" >}}
{{< hide-and-re-highlight-menu link_url="/en/os/%s/install/quickstart/aws/" depad="true" >}}
{{< breadcrumb-remove link_url="/en/os/%s/install/quickstart/">}}
{{< breadcrumb-remove link_url="/en/os/%s/install/quickstart/aws/">}}


## Prerequisites

- An AWS EC2 Instance ID (begins with `i-`) of a Bottlerocket instance
- [`aws-cli`](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions): Used to interact with AWS services.
- [SSM Session Manager Plugin for AWS CLI](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html): Used to enter SSM sessions on Bottlerocket nodes through the AWS CLI.

## Interacting With a Bottlerocket Node Through Host Containers

Run the following command to enter an SSM session on the node:

```bash
aws ssm start-session --target INSTANCE_ID
```

Replace `INSTANCE_ID` with the instance ID you picked earlier.

Entering the SSM session will place you in the control container.

You should see output similar to the following:

```bash
          Welcome to Bottlerocket's control container!
    ╱╲
   ╱┄┄╲   This container gives you access to the Bottlerocket API,
   │▗▖│   which in turn lets you inspect and configure the system.
  ╱│  │╲  You'll probably want to use the `apiclient` tool for that;
  │╰╮╭╯│  for example, to inspect the system:
    ╹╹
             apiclient -u /settings

You can run `apiclient --help` for usage details, and check the main
Bottlerocket documentation for descriptions of all settings and examples of
changing them.

If you need to debug the system further, you can use the admin container.  The
admin container has more debugging tools installed and allows you to get root
access to the host.  The easiest way to get started is like this, which enables
and enters the admin container using apiclient:

   enter-admin-container

You can also access the admin container through SSH if you have network access.
Just enable the container like this, then SSH to the host:

   enable-admin-container

You can disable the admin container like this:

   disable-admin-container

[ssm-user@control]$
```

Use `apiclient` to get the Bottlerocket host Message Of The Day (MOTD):

```bash
apiclient get settings.motd
```

You should see output similar to the following:

```bash
{
  "settings": {
    "motd": "Hello from eksctl!"
  }
}
```

### Exploring the Admin Container

From the control container, you can enter the admin container:

```bash
enter-admin-container
```

Then, check the `/etc/os-release` file contents from the _Bottlerocket host filesystem_, mounted at `/.bottlerocket/rootfs/`.
You should see something similar to the following:

{{< tabpane text=true right=true >}}
  {{< tab header="Orchestrator:" disabled=true />}}
  {{< tab header="EKS" >}}
[root@admin]# cat /.bottlerocket/rootfs/etc/os-release
{{< os-release-example orchestrator="k8s" build_id="6ef1139f" >}}
  {{< /tab >}}
  {{< tab header="ECS" >}}
[root@admin]# cat /.bottlerocket/rootfs/etc/os-release
{{< os-release-example orchestrator="ecs" build_id="32e9bb46" >}}
  {{< /tab >}}
{{< /tabpane >}}

Congratulations!
You have successfully navigated a Bottlerocket system through the control and admin containers.

{{< on-github >}}
