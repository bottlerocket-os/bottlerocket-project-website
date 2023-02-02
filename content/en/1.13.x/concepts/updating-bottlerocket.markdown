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

For the `aws-k8s-*` variants of Bottlerocket, there are a handful of possible ways to update Bottlerocket: Brupop, the EKS Console, `eksctl`, and SSM Automation Documents.
The following sections discuss each of these methods.

#### Brupop

This is the recommended method to update Bottlerocket on Kubernetes.
The following sections should help you understand why, when, and how to use Brupop.

//TODO SCRATCH NOTES

- take what, why, and when out of this document and add to a new doc about comparing the different ways to update Bottlerocket

##### What is Brupop?

The **B**ottle**r**ocket **up**date **op**erator (Brupop) is a [Kubernetes Operator](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/) that manages the Bottlerocket update process for you.
It is designed to be a simple, safe, and convenient way to update your Bottlerocket nodes.
To read more about the design of Brupop, see the [Brupop deep dive design document](https://github.com/bottlerocket-os/bottlerocket-update-operator/blob/develop/design/1.0.0-release.md).

##### Why should I use Brupop?

Brupop was designed to be a great catch-all solution to the often tricky operator task of updating operating systems on Kubernetes cluster nodes.
Brupop abstracts away and automates the node OS update process.
This means that you can update your Bottlerocket nodes without having to worry about the details of the update process.
As Bottlerocket updates roll out, Brupop will drain your nodes, prepare them for update, update them, and then schedule your workloads back onto the nodes.
This means that you should not see any disruption to your cluster workloads.

For example, if you have a cluster with 5 nodes, you can simply apply the appropriate Brupop label to those nodes and `kubectl apply` our manifest to have the Brupop stack installed.

##### When would I use Brupop?

Ideally, you would always use Brupop for your Bottlerocket updates on Kubernetes.
If your cluster is allowed to access the public internet, then you should be able to use Brupop.

In some cases, like with heavily restricted network environments, you may not be able to use Brupop.
In particular, Brupop uses a public endpoint, `updates.bottlerocket.aws`, to get the TUF metadata.
It may or may not be acceptable in your usecase to punch a small hole in your firewall to access that public endpoint.
There is a good [discussion on this topic in the Brupop repository](https://github.com/bottlerocket-os/bottlerocket-update-operator/pull/387).
In such a case, if you are using EKS, you can use the EKS Console or `eksctl` to update your Bottlerocket nodes, as discussed below.

##### How do I use brupop?

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

If your Bottlerocket nodes are registered with AWS Systems Manager (SSM), you can use SSM Automation Documents to update your Bottlerocket nodes.

#### SSM Automation Document: Update Bottlerocket

SSM Automation Documents allow you to specify shell commands to run on target nodes.
In our case, we will use the `aws:runShellScript` SSM Action to run the `apiclient update` command on our Bottlerocket nodes.
Please see the [`apiclient` documentation](https://github.com/bottlerocket-os/bottlerocket/blob/develop/sources/api/apiclient/README.md#update-mode) to learn more about `apiclient update`.

//TODO SCRATCH NOTES

- create ssm document
- apply ssm document to target nodes

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

## Locking To A Specific Release

### SSM Automation Document: Lock to a specific release

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
