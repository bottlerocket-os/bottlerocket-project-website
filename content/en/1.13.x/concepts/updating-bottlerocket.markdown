# Updating Bottlerocket

There are many ways to update Bottlerocket, including:

- Running `apiclient` commands directly in the control container
- [Using the ECS updater](#ecs)
- [Brupop](#brupop), using the [EKS Console](#eks-console), and [`eksctl`](#eksctl) on Kubernetes
- [Applying SSM Command Documents](#ssm) to your nodes

It is also possible to [lock your nodes to a specific release](#locking-to-a-specific-release).

## Introduction

Bottlerocket is designed to be updated in an [image-based fashion](https://github.com/bottlerocket-os/bottlerocket#updates).
This means that updates are applied by downloading an image of the entire operating system to a different partition on disk, then switching to using that partition when the system is rebooted.
This is done instead of a series of individual package updates on the current operating system partition.
This is a departure from the traditional package-based Linux update model such as `apt` or `yum`, which are what you would find in Ubuntu or Amazon Linux.

## Ways To Update

There are a few ways to update Bottlerocket.
The method you choose depends on the [Bottlerocket variant](https://github.com/bottlerocket-os/bottlerocket#variants) you are using and your environment.

The ways to update Bottlerocket can be classified into two main categories: _in-place updates_ and _node replacement_.
_In-place updates_ are updates that are applied to the same node (no infrastructure reprovisioning), while _node replacement_ is when you replace an existing node with a new node that is running the updated version of Bottlerocket.

The following table shows whether a given update method is an _in-place update_ or a _node replacement_.

In-Place Update | Node Replacement
--- | ---
[`apiclient` commands](#apiclient-commands) | [EKS Console](#eks-console)
[ECS updater](#ecs) | [`eksctl`](#eksctl)
[Brupop](#brupop) |
[SSM command documents](#ssm) |


## In-Place Updates

### `apiclient` commands

### ECS

For the `aws-ecs-*` variants of Bottlerocket, you can use the [ECS updater](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#how-it-works).
See the [ECS updater installation documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#installation) for more information on how to install and use the ECS updater.

By default, the ECS updater checks for updates every 12 hours.

In summary, installing the ECS updater involves the following steps:

1. [Get subnet information](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#subnet-info) for your cluster:
    - Get the ID of the VPC you want to use for the ECS updater.
    - Get the Subnet ID from the VPC you found in the previous step (remember, the subnet must have internet access).
2. [Get the name of the CloudWatch Logs log group](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#log-group) where the Bottlerocket ECS updater will send its logs.
3. Get the name of the ECS cluster where you are running Bottlerocket container instances.
4. [Install the Bottlerocket ECS updater](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#install) using a CloudFormation template (provided in the full [ECS updater installation documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#installation)).

Detailed steps, including commands to run, are provided in the [ECS updater documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#installation).

### Kubernetes

For the `aws-k8s-*` variants of Bottlerocket, there are a handful of possible ways to update Bottlerocket: Brupop, the EKS Console, `eksctl`, and SSM Command Documents.
The following sections discuss each of these methods.

#### Brupop

This is the recommended method to update Bottlerocket on Kubernetes.

##### Brupop: Release YAML

How to install Brupop is covered in the [Brupop documentation](https://github.com/bottlerocket-os/bottlerocket-update-operator#installation).

The steps cover the following:

1. Install `cert-manager`.
2. Install `brupop`.
3. Label your Bottlerocket nodes with the appropriate label.
In most cases, you will want to use `bottlerocket.aws/updater-interface-version=2.0.0`.

Detailed steps, including commands to run, are provided in the Brupop documentation, linked above.

#### EKS

When running the `aws-k8s-*` variants of Bottlerocket on EKS, you can use either the EKS Console or `eksctl` to update your Bottlerocket nodes if you do not want to use Brupop.

##### EKS Console

In order to update your Bottlerocket nodes in an EKS cluster using the EKS Console, you will need to do the following:

1. Go to the EKS Console.
For example, for `us-west-2`, it is: https://us-west-2.console.aws.amazon.com/eks/home?region=us-west-2#/clusters
2. Click on the cluster name that you want to update.
3. Go to the "Compute" tab.
4. Under "Node groups", look for the node group that you want to update.
5. In the "AMI Release Version" column, click on "Update now".
6. A modal box will pop up.
Choose your desired update strategy (e.g. "Rolling update") and press the "Update" button.

This will update your Bottlerocket nodegroup, and subsequently your Bottlerocket nodes, to the latest version of Bottlerocket.

Detailed instructions can be found in the [EKS User Guide, in the "AWS Management Console" tab](https://docs.aws.amazon.com/eks/latest/userguide/update-managed-node-group.html#mng-update).

##### `eksctl`

As described in the [EKS User Guide](https://docs.aws.amazon.com/eks/latest/userguide/update-managed-node-group.html#mng-update), you can also use `eksctl` to update your Bottlerocket nodes.
For example, you can run the following command to update your Bottlerocket nodes to the latest version of Bottlerocket, replacing `NODEGROUP_NAME`, `CLUSTER_NAME`, and `REGION_CODE` with your own values:

```bash
eksctl upgrade nodegroup \
  --name=NODEGROUP_NAME \
  --cluster=CLUSTER_NAME \
  --region=REGION_CODE
```

Further details and notes are available in the EKS User Guide linked above.

### SSM

If your Bottlerocket nodes are registered with AWS Systems Manager (SSM), you can use SSM Command Documents to update your Bottlerocket nodes.

**Important:** when using the SSM instructions below to update Bottlerocket nodes, workloads will NOT be drained from the node before rebooting the node (unlike when using Brupop, for example).

#### SSM Command Document: Update Bottlerocket

SSM Command Documents allow you to specify shell commands to run on target nodes.
In our case, we will use the `aws:runShellScript` SSM Action to run the `apiclient update` command on our Bottlerocket nodes.
Please see the [`apiclient` documentation](https://github.com/bottlerocket-os/bottlerocket/blob/develop/sources/api/apiclient/README.md#update-mode) to learn more about `apiclient update`.

The following two subsections will cover how to create two SSM Command Documents: one Command Document for preparing a Bottlerocket node to use the latest available version of the Bottlerocket OS image, and one Command Document for rebooting a Bottlerocket node (in order to reboot into and use that latest acquired Bottlerocket OS image).

Both steps can be combined into a single SSM Command Document, however keeping the two steps separate allows you to apply updates and reboot your Bottlerocket nodes in separate patterns, if needed.
For example, you may want to apply updates to your Bottlerocket nodes in groups, but reboot them in a rolling pattern.

##### 1. Create the SSM Command Document for Updating

The following steps create an SSM Command Document that will update a Bottlerocket node to the latest version of Bottlerocket.

1. Go to the [SSM Console](https://console.aws.amazon.com/systems-manager/).
2. Click on "Documents" in the left-hand menu.
3. Click on the "Create document" button in the top-right corner.
4. Click on "Command or Session" in the drop-down menu that appears.
5. Name your document.
For example, let's name the document `update-bottlerocket-node`.
6. _Optional:_ select a Target type (e.g. `/AWS::EC2::Instance`).
7. Document type: select "Command document".
8. In the "Content" box, select "YAML".
9. Paste the following YAML into the "Content" box:

###### SSM Command Document: Check For and Apply Updates to a Bottlerocket Node

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

10. Click on "Create document".

Congratulations!
You now have an SSM Command Document that will update a Bottlerocket node to the latest version of Bottlerocket.

A quick overview of what `apiclient update apply --check` does:

1. First, the `--check` flag executes: `apiclient` checks for the available Bottlerocket OS images and selects the latest one.
2. Next, the `apply` subcommand executes: `apiclient` downloads the latest Bottlerocket OS image and prepares the Bottlerocket node to use it.

##### 2. Create the SSM Command Document for Rebooting

The following steps create an SSM Command Document that will reboot a Bottlerocket node.

1. Go to the [SSM Console](https://console.aws.amazon.com/systems-manager/).
2. Click on "Documents" in the left-hand menu.
3. Click on the "Create document" button in the top-right corner.
4. Click on "Command or Session" in the drop-down menu that appears.
5. Name your document.
For example, let's name the document `reboot-bottlerocket-node`.
6. _Optional:_ select a Target type (e.g. `/AWS::EC2::Instance`).
7. Document type: select "Command document".
8. In the "Content" box, select "YAML".
9. Paste the following YAML into the "Content" box:

###### SSM Command Document: Reboot a Bottlerocket Node

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

10. Click on "Create document".

Congratulations!
You now have an SSM Command Document that will reboot a Bottlerocket node.

##### 3. Apply the SSM Command Documents to Your Bottlerocket Nodes

After creating the two SSM Command Documents, you can apply them to your Bottlerocket nodes.

The following steps apply the first SSM Command Document (named `update-bottlerocket-node` above) to your Bottlerocket nodes.

1. Go to the [SSM Console](https://console.aws.amazon.com/systems-manager/).
2. Click on "Documents" in the left-hand menu.
3. Click on the "Owned by me" tab.
4. Select the `update-bottlerocket-node` SSM Command Document (created using steps above.)
5. Click on the "Run command" button in the top-right corner.
6. In the "Target selection" section of the page, select the Bottlerocket nodes that you want to update using one of the available methods (by instance tag, manually, or by resource group).

    - If you are using EKS, you can select all nodes in a given EKS cluster by Instance Tag: specify `eks:cluster-name` as the Tag key, with the Tag value set to your cluster name.

7. For simplicity in this example, we will _uncheck_ "Enable an S3 bucket" in the "Output options" section of the page.
(You may want to check this option if you want to store the output of the SSM Command Document in an S3 bucket for later inspection or auditing reasons.)
8. Click on the "Run" button in the bottom-right corner.

After running the SSM Command Document, you will be taken to the SSM Command status page.
If you would like to see the output of the SSM Command Document that you just ran, you can click on an Instance ID in the "Targets and outputs" section of the page and see any output or errors.

Once the SSM Command Document has finished running, you can apply the second SSM Command Document (named `reboot-bottlerocket-node` above) to your Bottlerocket nodes using the same process as above.

## Locking To A Specific Release

You can also lock your Bottlerocket nodes to a specific release using the Bottlerocket Settings API.
The following steps use an SSM Command Document to call `apiclient` and achieve that.

1. Go to the [SSM Console](https://console.aws.amazon.com/systems-manager/).
2. Click on "Documents" in the left-hand menu.
3. Click on the "Create document" button in the top-right corner.
4. Click on "Command or Session" in the drop-down menu that appears.
5. Name your document.
For example, let's name the document `version-lock-bottlerocket-node`.
6. _Optional:_ select a Target type (e.g. `/AWS::EC2::Instance`).
7. Document type: select "Command document".
8. In the "Content" box, select "YAML".
9. Paste the following YAML into the "Content" box:

### SSM Command Document: Lock to a Specific Release

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

10. Click on "Create document".
You should now have the `version-lock-bottlerocket-node` SSM Command Document available in the SSM "Owned by me" tab in the "Documents" section of the SSM Console.

_A quick explanation of the `apiclient` command used above:_

Two settings are set: `updates.version-lock` and `updates.ignore-waves`.

- `updates.version-lock`: which version of Bottlerocket to lock to when `apiclient` checks for updates.
- `updates.ignore-waves`: ignore the [update waves behavior](https://github.com/bottlerocket-os/bottlerocket/tree/develop/sources/updater/waves) and update the Bottlerocket node immediately.

### Applying a Version Lock

In order to apply a version lock using SSM, follow these steps:

1. First, tell your Bottlerocket nodes that you want them to lock to a specific version.
    - Apply the `version-lock-bottlerocket-node` SSM Command Document previously described.
2. Next, tell your Bottlerocket nodes to prepare to boot into that specific version.
    - Apply the `update-bottlerocket-node` SSM Command Document previously described.
3. Finally, reboot your Bottlerocket nodes into the version you locked to.
    - Apply the `reboot-bottlerocket-node` SSM Command Document previously described.

#### Applying the `version-lock-bottlerocket-node` SSM Command Document

In order to apply the `version-lock-bottlerocket-node` SSM Command Document to your nodes, you will need to:

1. Go to the [SSM Console](https://console.aws.amazon.com/systems-manager/).
2. Click on "Documents" in the left-hand menu.
3. Click on the "Owned by me" tab.
4. Select the `version-lock-bottlerocket-node` SSM Command Document (created using steps above.)
5. Click on the "Run command" button in the top-right corner.
6. In the "Command parameters" section of the page, specify the version of Bottlerocket that you want to lock to.
Remember to use the exact version number: for example, `1.12.0`, not `1.12`.
7. In the "Target selection" section of the page, select the Bottlerocket nodes that you want to update using one of the available methods (by instance tag, manually, or by resource group).

    - If you are using EKS, you can select all nodes in a given EKS cluster by Instance Tag: specify `eks:cluster-name` as the Tag key, with the Tag value set to your cluster name.

8. For simplicity in this example, we will _uncheck_ "Enable an S3 bucket" in the "Output options" section of the page.
(You may want to check this option if you want to store the output of the SSM Command Document in an S3 bucket for later inspection or auditing reasons.)
9. Click on the "Run" button in the bottom-right corner.

### Removing a Version Lock

In order to remove a version lock using SSM, create and apply the following SSM Command Document to the Bottlerocket nodes you want to remove a Version Lock from (the SSM Command Document can be named `version-unlock-bottlerocket-node` for example):

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
