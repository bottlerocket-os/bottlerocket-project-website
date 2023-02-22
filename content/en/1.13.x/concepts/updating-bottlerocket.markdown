# Updating Bottlerocket

There are many ways to update Bottlerocket, including:

- Running [`apiclient` commands](#apiclient-commands) directly in the [control container](https://github.com/bottlerocket-os/bottlerocket#control-container)
- The [ECS updater](#ecs)
- [Brupop](#brupop), the [EKS Console](#eks-console), and [`eksctl`](#eksctl) on Kubernetes
- [Applying SSM Command Documents](#ssm) to your nodes

It is also possible to [lock your nodes to a specific release](#locking-to-a-specific-release).

## Introduction

Bottlerocket is designed to be updated in an [image-based fashion](https://github.com/bottlerocket-os/bottlerocket#updates).
This means that updates are applied by downloading an image of the entire operating system to a different partition on disk, then switching to using that partition when the system is rebooted.
This is done instead of a series of individual package updates on the current operating system partition.
This is a departure from the traditional package-based Linux update model such as `apt` or `yum`, which are what you would find in Ubuntu or Amazon Linux.

## Ways To Update

The update method you choose depends on the [Bottlerocket variant](https://github.com/bottlerocket-os/bottlerocket#variants) you are using and your environment.

The ways to update Bottlerocket can be classified into two main categories: _in-place updates_ and _node replacement_.
_In-place updates_ are updates that are applied to the same node (no infrastructure reprovisioning), while _node replacement_ is when you replace an existing node with a new node that is running the updated version of Bottlerocket.

At its core, an _in-place update_ is a call to the Bottlerocket API server using `apiclient`.
The `apiclient` command can be run from the [control container](https://github.com/bottlerocket-os/bottlerocket#control-container).
There are also orchestrated systems that perform the `apiclient` calls for you: the [ECS updater](#ecs) for ECS, [Brupop](#brupop) for Kubernetes, and [SSM Command Documents](#ssm) for both.

The following table shows whether a given update method is an _in-place update_ or a _node replacement_.

In-Place Updates | Node Replacement
--- | ---
[`apiclient` commands](#apiclient-commands) | [EKS Console](#eks-console)
[ECS updater](#ecs) | [`eksctl`](#eksctl)
[Brupop](#brupop) |
[SSM command documents](#ssm) |

## In-Place Updates

### `apiclient` Commands

At its core, updating Bottlerocket consists of three steps: checking for an update, applying an update, and rebooting into the new Bottlerocket version.

These steps have specific `apiclient` commands associated with them:

#### Check for Update

In order to check for an update using `apiclient`, issue the following command in the control container:

```bash
apiclient update check
```

#### Apply Update

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

#### Reboot Into the New Version

After applying the update, reboot the system in order to begin using the new version of Bottlerocket.
That can be done with the following command:

```bash
apiclient reboot
```

### ECS

For the `aws-ecs-*` variants of Bottlerocket, use the [ECS updater](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#how-it-works).
See the [ECS updater installation documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#installation) for more information on how to install and use the ECS updater.

By default, the ECS updater checks for updates every 12 hours.

In order to install the ECS updater, you need a few different pieces of information: the subnet information for your cluster, the name of the CloudWatch Logs log group where you want logs stored, and the name of the ECS cluster you want the ECS updater to keep updated.
Further information on how to get that information can be found in the [Getting Started section of the ECS updater documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#getting-started).
After you've gathered those three values, you are ready to install the ECS updater.

Detailed installation steps, including commands to run, are provided in the [Install section of the ECS updater documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#install).

### Kubernetes

For the `aws-k8s-*` variants of Bottlerocket, there are a handful of possible ways to update Bottlerocket: Brupop, the EKS Console, `eksctl`, and SSM Command Documents.
The following sections discuss each of these methods.

#### Brupop

The recommended method to update your Bottlerocket nodes on Kubernetes is with Brupop.

##### Brupop: Install via Released YAML

Brupop installation via the released YAML file is covered in the [Brupop documentation](https://github.com/bottlerocket-os/bottlerocket-update-operator#installation).

### SSM

If your Bottlerocket nodes are registered with AWS Systems Manager (SSM), it may be convenient for you to use SSM Command Documents to update your Bottlerocket nodes.

**Important:** when using the SSM instructions below to update Bottlerocket nodes, workloads are _not_ be drained from the node before rebooting the node (unlike when using Brupop, for example).

#### SSM Command Document Method

This method performs the same action as the [`apiclient` commands](#apiclient-commands) method above, but uses SSM Command Documents rather than interactively running the `apiclient` commands from the [control container](https://github.com/bottlerocket-os/bottlerocket#control-container).
SSM Command Documents allow you to specify shell commands to run on target nodes.
Use the `aws:runShellScript` SSM Action inside SSM Command Documents to run the `apiclient update` command on your Bottlerocket nodes.
See the [`apiclient` documentation](https://github.com/bottlerocket-os/bottlerocket/blob/develop/sources/api/apiclient/README.md#update-mode) to learn more about `apiclient update`.

The following three subsections cover how to create two SSM Command Documents and apply them to your Bottlerocket nodes: one Command Document updates and prepares a Bottlerocket node to use the latest available version of the Bottlerocket image, and the other Command Document reboots a Bottlerocket node in order to use that latest acquired Bottlerocket image.

Both the update and reboot steps can be combined into a single SSM Command Document, however keeping the two steps separate allows you to apply updates and reboot your Bottlerocket nodes in separate patterns, if needed.
For example, you may want to apply updates to your Bottlerocket nodes all at once, but reboot them in groups.

##### 1. Create the SSM Command Document for Updating Nodes

To create an SSM Command Document, follow the steps in the [AWS Systems Manager User Guide: "Create an SSM document (console)"](https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-console.html).
Remember to select "YAML" in the "Content" box, since the [SSM Command Document below](#ssm-command-document-check-for-and-apply-updates-to-a-bottlerocket-node) is formatted in YAML.

A quick overview of what `apiclient update apply --check` does:

1. First, the `--check` flag executes: `apiclient` checks for the available Bottlerocket OS images and selects the latest one.
2. Next, the `apply` subcommand executes: `apiclient` downloads the latest Bottlerocket OS image and prepares the Bottlerocket node to use it.

###### SSM Command Document: Check For and Apply Updates to a Bottlerocket Node

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

##### 2. Create the SSM Command Document for Rebooting Nodes

To create an SSM Command Document, follow the steps in the [AWS Systems Manager User Guide: "Create an SSM document (console)"](https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-console.html).
Remember to select "YAML" in the "Content" box, since the [SSM Command Document below](#ssm-command-document-reboot-a-bottlerocket-node) is formatted in YAML.

###### SSM Command Document: Reboot a Bottlerocket Node

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

##### 3. Apply the SSM Command Documents to Your Bottlerocket Nodes

After creating the two SSM Command Documents above ([`update-bottlerocket-node`](#ssm-command-document-check-for-and-apply-updates-to-a-bottlerocket-node) and [`reboot-bottlerocket-node`](#ssm-command-document-reboot-a-bottlerocket-node)), apply them to your Bottlerocket nodes.

To apply SSM Command Documents to your Bottlerocket nodes, follow the steps in the [AWS Systems Manager User Guide: "To send a command using Run Command"](https://docs.aws.amazon.com/systems-manager/latest/userguide/running-commands-console.html).

If you are using EKS, select all nodes in a given EKS cluster by specifying an instance tag in the "Target selection" section of the page.
Specify `eks:cluster-name` as the tag key, with the tag value set to your cluster name.

After running the SSM Command Document, you are taken to the SSM Command status page.
If you would like to see the output of the SSM Command Document that you just ran, click on an Instance ID in the "Targets and outputs" section of the page and see any output or errors.

Once the [first SSM Command Document (`update-bottlerocket-node`)](#ssm-command-document-check-for-and-apply-updates-to-a-bottlerocket-node) has finished running, apply the [second SSM Command Document (`reboot-bottlerocket-node`)](#ssm-command-document-reboot-a-bottlerocket-node) to your Bottlerocket nodes using the same process as above.

## Node Replacement

### EKS

When running the `aws-k8s-*` variants of Bottlerocket on EKS, use either the EKS Console or [`eksctl`](https://eksctl.io/) to update your Bottlerocket nodes using the _node replacement_ method.
This means that you are replacing your existing Bottlerocket nodes with new Bottlerocket nodes, rather than updating your existing Bottlerocket nodes in-place.

#### EKS Console

In order to update your Bottlerocket nodes in an EKS cluster using the EKS Console, follow the [steps found under the "AWS Management Console" tab, in the EKS User Guide](https://docs.aws.amazon.com/eks/latest/userguide/update-managed-node-group.html#mng-update).

#### `eksctl`

Using [`eksctl`](https://eksctl.io/) is another option to update your Bottlerocket nodes.
Specific commands can be found in the [EKS User Guide: "Update a node group version", on the `eksctl` tab](https://docs.aws.amazon.com/eks/latest/userguide/update-managed-node-group.html#mng-update).

## Locking To A Specific Release

Locking your Bottlerocket nodes to a specific release is possible using the Bottlerocket Settings API.

_A quick explanation of the `apiclient` command used below:_

Two settings are set: `updates.version-lock` and `updates.ignore-waves`.

- `updates.version-lock`: which version of Bottlerocket to lock to when `apiclient` checks for updates.
- `updates.ignore-waves`: ignore the [update waves behavior](https://github.com/bottlerocket-os/bottlerocket/tree/develop/sources/updater/waves) and update the Bottlerocket node immediately.

To create an SSM Command Document, follow the steps in the [AWS Systems Manager User Guide: "Create an SSM document (console)"](https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-console.html).
Remember to select "YAML" in the "Content" box, since the [SSM Command Document below](#ssm-command-document-lock-to-a-specific-release) is formatted in YAML.

### SSM Command Document: Lock to a Specific Release

The following SSM Command Document is referred to in this documentation as `version-lock-bottlerocket-node`:

```yaml
---
schemaVersion: "2.2"
description: "Lock a Bottlerocket host to a specific version via the Bottlerocket Settings API"
parameters:
  TargetVersion:
    type: "String"
    description: "The target version of Bottlerocket to lock to (e.g. 1.12.0)"
mainSteps:
  - name: "setTargetVersion"
    action: "aws:runShellScript"
    inputs:
      timeoutSeconds: '20'
      runCommand:
        - "apiclient set updates.version-lock=\"{{ TargetVersion }}\" updates.ignore-waves=true"
```

You should now have the above SSM Command Document available in the SSM "Owned by me" tab in the "Documents" section of the SSM Console.

### Applying a Version Lock

In order to apply a version lock using SSM, follow these steps:

1. First, tell your Bottlerocket nodes that you want them to lock to a specific version.
    - Apply the [`version-lock-bottlerocket-node` SSM Command Document previously described](#ssm-command-document-lock-to-a-specific-release).
        - In the "Command parameters" section of the Run Command page, remember to specify the full version of Bottlerocket that you want to lock to (e.g. `1.12.0`, not `1.12`).
        - If you are using EKS, select all nodes in a given EKS cluster by specifying an instance tag in the "Target selection" section of the page.
        Specify `eks:cluster-name` as the tag key, with the tag value set to your cluster name.
2. Next, tell your Bottlerocket nodes to prepare to boot into that specific version.
    - Apply the [`update-bottlerocket-node` SSM Command Document previously described](#ssm-command-document-check-for-and-apply-updates-to-a-bottlerocket-node).
3. Finally, reboot your Bottlerocket nodes into the version you locked to.
    - Apply the [`reboot-bottlerocket-node` SSM Command Document previously described](#ssm-command-document-reboot-a-bottlerocket-node).

### Removing a Version Lock

In order to remove a version lock using SSM, [create](https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-console.html) and [apply](https://docs.aws.amazon.com/systems-manager/latest/userguide/running-commands-console.html) the following SSM Command Document to the Bottlerocket nodes you want to remove a Version Lock from (the SSM Command Document can be named `version-unlock-bottlerocket-node` for example):

#### SSM Command Document: Remove a Version Lock

```yaml
---
schemaVersion: "2.2"
description: "Remove a Version Lock from a Bottlerocket host via the Bottlerocket Settings API"
mainSteps:
  - name: "unsetTargetVersion"
    action: "aws:runShellScript"
    inputs:
      timeoutSeconds: '20'
      runCommand:
        - "apiclient set updates.version-lock=\"latest\" updates.ignore-waves=false"
```
