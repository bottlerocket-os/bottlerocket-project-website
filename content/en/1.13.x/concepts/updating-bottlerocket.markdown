# Updating Bottlerocket

This document covers the different ways to update Bottlerocket (for [ECS](#ecs), [Kubernetes](#kubernetes), and [SSM](#ssm)), as well as how to lock your nodes to a specific release.

## Introduction

Bottlerocket is designed to be updated in an [image-based fashion](https://github.com/bottlerocket-os/bottlerocket#updates).
This means that updates are applied by replacing the entire image on disk, rather than applying a series of individual package updates.
This is a departure from the traditional package-based Linux update model such as `apt` or `yum`, which are what you would find in Ubuntu or Amazon Linux.

## Ways To Update

There are a few ways to update Bottlerocket.
The method you choose depends on the [Bottlerocket variant](https://github.com/bottlerocket-os/bottlerocket#variants) you are using and your environment.

### ECS

For the `aws-ecs-*` variants of Bottlerocket, we provide an [ECS updater](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#how-it-works).
Please see the [ECS updater installation documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#installation) for more information on how to install and use the ECS updater.

Essentially, you will need to do the following:

1. [Get subnet information](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#subnet-info) for your cluster:
    - Get the ID of the VPC you want to use for the ECS updater.
    - Get the Subnet ID from the VPC you found in the previous step (remember, the subnet must have internet access).
2. [Get the name of the CloudWatch Logs log group](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#log-group) where the Bottlerocket ECS updater will send its logs.
3. Get the name of the ECS cluster where you are running Bottlerocket container instances.
4. [Install the Bottlerocket ECS updater](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#install) using a CloudFormation template (provided in the full ECS updater installation documentation, linked above).

Detailed steps, including commands to run, are provided in the ECS updater documentation, linked above.

### Kubernetes

For the `aws-k8s-*` variants of Bottlerocket, there are a handful of possible ways to update Bottlerocket: Brupop, the EKS Console, `eksctl`, and SSM Command Documents.
The following sections discuss each of these methods.

#### Brupop

This is the recommended method to update Bottlerocket on Kubernetes.

##### Brupop: Release YAML

How to install Brupop is covered in the [Brupop documentation](https://github.com/bottlerocket-os/bottlerocket-update-operator#installation).

Essentially, you will need to do the following:

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

#### SSM Command Document: Update Bottlerocket

SSM Command Documents allow you to specify shell commands to run on target nodes.
In our case, we will use the `aws:runShellScript` SSM Action to run the `apiclient update` command on our Bottlerocket nodes.
Please see the [`apiclient` documentation](https://github.com/bottlerocket-os/bottlerocket/blob/develop/sources/api/apiclient/README.md#update-mode) to learn more about `apiclient update`.

The following two subsections will cover how to create two SSM Command Documents: one Command Document for preparing a Bottlerocket node to use the latest available version of the Bottlerocket OS image, and one Command Document for rebooting a Bottlerocket node (in order to reboot into and use that latest acquired Bottlerocket OS image).

Both steps can be combined into a single SSM Command Document, however keeping the two steps separate allows you to apply updates and reboot your Bottlerocket nodes in separate patterns, if needed.
For example, you may want to apply updates to your Bottlerocket nodes in groups, but reboot them in a rolling pattern.

##### 1. Create the SSM Command Document for Updating

The following steps will create an SSM Command Document that will update a Bottlerocket node to the latest version of Bottlerocket.

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

The following steps will create an SSM Command Document that will reboot a Bottlerocket node.

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

- apply SSM documents to target nodes

## Locking To A Specific Release

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

//TODO SCRATCH NOTES

- then run the ssm doc from before to move the nodes to the target version
- explain what each setting does
- also add a kubectl section: https://opensearch.org/blog/bottlerocket-k8s-fluent-bit/ -- "Typically, you would run apiclient from the control container" (find the `container` spec and see how to run it with kubectl exec) -- FIND OUT HOW TO oneshot run or --rm the container or terminate after exit
