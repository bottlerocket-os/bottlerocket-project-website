+++
title = "In-Place Updates"
type = "docs"
description = "How to update a Bottlerocket node in-place"
+++

Bottlerocket clusters can be updated in-place, meaning that the existing Bottlerocket nodes will download updated software to use, without re-provisioning the nodes.
There are different ways to update in-place depending on your environment.

## `apiclient` Commands

At its core, updating Bottlerocket consists of three steps: checking for an update, applying an update, and rebooting into the new Bottlerocket version.

These steps have specific `apiclient` commands associated with them:

### Check for Update

In order to check for an update using `apiclient`, issue the following command in the control container:

```bash
apiclient update check
```

### Apply Update

If an update is found while checking for an update, apply the update using the following command:

```bash
apiclient update apply
```

That command downloads the updated Bottlerocket image, apply it to a separate partition on disk, and prepare the system to use the new version of Bottlerocket.
In particular, [the partition that was just updated with the new Bottlerocket image is marked as the "active" next boot partition](https://github.com/bottlerocket-os/bottlerocket#updates-1).

It is also possible to combine the Check and Apply steps into a single command:

```bash
apiclient update apply --check
```

That command first checks for an update, and then applies the update if one is found.

### Reboot Into the New Version

After applying the update, reboot the system in order to begin using the new version of Bottlerocket.
That can be done with the following command:

```bash
apiclient reboot
```

## ECS

For the `aws-ecs-*` variants of Bottlerocket, use the [ECS updater](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#how-it-works).
See the [ECS updater installation documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#installation) for more information on how to install and use the ECS updater.

By default, the ECS updater checks for updates every 12 hours.

In order to install the ECS updater, you need a few different pieces of information: the subnet information for your cluster, the name of the CloudWatch Logs log group where you want logs stored, and the name of the ECS cluster you want the ECS updater to keep updated.
Further information on how to get that information can be found in the [Getting Started section of the ECS updater documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#getting-started).
After you've gathered those three values, you are ready to install the ECS updater.

Detailed installation steps, including commands to run, are provided in the [Install section of the ECS updater documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#install).

## Kubernetes

For the `aws-k8s-*` variants of Bottlerocket, there are a handful of possible ways to update Bottlerocket: Brupop, the EKS Console, `eksctl`, and SSM Command Documents.
The following sections discuss each of these methods.

### Brupop

The recommended method to update your Bottlerocket nodes on Kubernetes is with Brupop.

#### Brupop: Install via Released YAML

Brupop installation via the released YAML file is covered in the [Brupop documentation](https://github.com/bottlerocket-os/bottlerocket-update-operator#installation).

## SSM

If your Bottlerocket nodes are registered with AWS Systems Manager (SSM), it may be convenient for you to use SSM Command Documents to update your Bottlerocket nodes.

**Important:** when using the SSM instructions below to update Bottlerocket nodes, workloads will _not_ be drained from the node before rebooting the node, causing interruptions to the workloads (unlike when using Brupop, for example).

### SSM Command Document Method

This method performs the same action as the [`apiclient` commands](#apiclient-commands) method above, but uses SSM Command Documents rather than interactively running the `apiclient` commands from the [control container](https://github.com/bottlerocket-os/bottlerocket#control-container).
SSM Command Documents allow you to specify shell commands to run on target nodes.
Use the `aws:runShellScript` SSM Action inside SSM Command Documents to run the `apiclient update` command on your Bottlerocket nodes.
See the [`apiclient` documentation](https://github.com/bottlerocket-os/bottlerocket/blob/develop/sources/api/apiclient/README.md#update-mode) to learn more about `apiclient update`.

The following three subsections cover how to create two SSM Command Documents and apply them to your Bottlerocket nodes: one Command Document updates and prepares a Bottlerocket node to use the latest available version of the Bottlerocket image, and the other Command Document reboots a Bottlerocket node in order to use that latest acquired Bottlerocket image.

Both the update and reboot steps can be combined into a single SSM Command Document, however keeping the two steps separate allows you to apply updates and reboot your Bottlerocket nodes in separate patterns, if needed.
For example, you may want to apply updates to your Bottlerocket nodes all at once, but reboot them in groups.

#### 1. Create the SSM Command Document for Updating Nodes

To create an SSM Command Document, follow the steps in the [AWS Systems Manager User Guide: "Create an SSM document (console)"](https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-console.html).
Remember to select "YAML" in the "Content" box, since the [SSM Command Document below](#ssm-command-document-check-for-and-apply-updates-to-a-bottlerocket-node) is formatted in YAML.

A quick overview of what `apiclient update apply --check` does:

1. First, the `--check` flag executes: `apiclient` checks for the available Bottlerocket OS images and selects the latest one.
2. Next, the `apply` subcommand executes: `apiclient` downloads the latest Bottlerocket OS image and prepares the Bottlerocket node to use it.

##### SSM Command Document: Check For and Apply Updates to a Bottlerocket Node

The following SSM Command Document is referred to in this documentation as `update-bottlerocket-node`:

```yaml
---
schemaVersion: "2.2"
description: "Update a Bottlerocket host via the Bottlerocket Update API"
mainSteps:
  - name: "updateBottlerocket"
    action: "aws:runShellScript"
    inputs:
      timeoutSeconds: '120'
      runCommand:
        - "apiclient update apply --check"
```

Congratulations!
You now have an SSM Command Document that updates a Bottlerocket node to the latest version of Bottlerocket.

#### 2. Create the SSM Command Document for Rebooting Nodes

To create an SSM Command Document, follow the steps in the [AWS Systems Manager User Guide: "Create an SSM document (console)"](https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-console.html).
Remember to select "YAML" in the "Content" box, since the [SSM Command Document below](#ssm-command-document-reboot-a-bottlerocket-node) is formatted in YAML.

##### SSM Command Document: Reboot a Bottlerocket Node

The following SSM Command Document is referred to in this documentation as `reboot-bottlerocket-node`:

```yaml
---
schemaVersion: "2.2"
description: "Reboot a Bottlerocket host via the Bottlerocket API"
mainSteps:
  - name: "updateBottlerocket"
    action: "aws:runShellScript"
    inputs:
      timeoutSeconds: '120'
      runCommand:
        - "apiclient reboot"
```

Congratulations!
You now have an SSM Command Document that reboots a Bottlerocket node.

#### 3. Apply the SSM Command Documents to Your Bottlerocket Nodes

After creating the two SSM Command Documents above ([`update-bottlerocket-node`](#ssm-command-document-check-for-and-apply-updates-to-a-bottlerocket-node) and [`reboot-bottlerocket-node`](#ssm-command-document-reboot-a-bottlerocket-node)), apply them to your Bottlerocket nodes.

To apply SSM Command Documents to your Bottlerocket nodes, follow the steps in the [AWS Systems Manager User Guide: "To send a command using Run Command"](https://docs.aws.amazon.com/systems-manager/latest/userguide/running-commands-console.html).

If you are using EKS, select all nodes in a given EKS cluster by specifying an instance tag in the "Target selection" section of the page.
Specify `eks:cluster-name` as the tag key, with the tag value set to your cluster name.

After running the SSM Command Document, you are taken to the SSM Command status page.
If you would like to see the output of the SSM Command Document that you just ran, click on an Instance ID in the "Targets and outputs" section of the page and see any output or errors.

Once the [first SSM Command Document (`update-bottlerocket-node`)](#ssm-command-document-check-for-and-apply-updates-to-a-bottlerocket-node) has finished running, apply the [second SSM Command Document (`reboot-bottlerocket-node`)](#ssm-command-document-reboot-a-bottlerocket-node) to your Bottlerocket nodes using the same process as above.

{{< on-github >}}
