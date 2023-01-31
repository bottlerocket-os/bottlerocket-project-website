# Updating Bottlerocket

## Introduction

Bottlerocket is designed to be updated in an [image-based fashion](https://github.com/bottlerocket-os/bottlerocket#updates). This means that updates are applied by replacing the entire image on disk, rather than applying a series of individual package updates. This is a departure from the traditional package-based Linux update model such as `apt` or `yum`, which are what you would find in Ubuntu or Amazon Linux.

## Ways To Update

There are a few ways to update Bottlerocket. The method you choose depends on the [Bottlerocket variant](https://github.com/bottlerocket-os/bottlerocket#variants) you are using and your environment.

### ECS

For the `aws-ecs-*` variants of Bottlerocket, we provide an [ECS updater](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#how-it-works). Please see the [ECS updater installation documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#installation) for more information on how to install and use the ECS updater.

### Kubernetes

For the `aws-k8s-*` variants of Bottlerocket, there are a few possible ways to update Bottlerocket: Brupop, the EKS Console, `eksctl`, and SSM Automation Documents. The following sections discuss each of these methods.

#### Brupop

This is the recommended method to update Bottlerocket on Kubernetes. The following sections should help you understand why, when, and how to use Brupop.

##### What is Brupop?

The **B**ottle**r**ocket **up**date **op**erator (Brupop) is a [Kubernetes Operator](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/) that manages the Bottlerocket update process for you. It is designed to be a simple, safe, and convenient way to update your Bottlerocket nodes. To read more about the design of Brupop, see the [Brupop deep dive design document](https://github.com/bottlerocket-os/bottlerocket-update-operator/blob/develop/design/1.0.0-release.md).

##### Why should I use Brupop?

Brupop was designed to be a great catch-all solution to the often tricky operator task of updating operating systems on Kubernetes cluster nodes. Brupop abstracts away and automates the node OS update process. This means that you can update your Bottlerocket nodes without having to worry about the details of the update process. As Bottlerocket updates roll out, Brupop will drain your nodes, prepare them for update, update them, and then schedule your workloads back onto the nodes. This means that you should not see any disruption to your cluster workloads.

For example, if you have a cluster with 5 nodes, you can simply apply the appropriate Brupop label to those nodes and `kubectl apply` our manifest to have the Brupop stack installed.

##### When would I use Brupop?

Ideally, you would always use Brupop for your Bottlerocket updates on Kubernetes. If your cluster is allowed to access the public internet, then you should be able to use Brupop.

In some cases, like with heavily restricted network environments, you may not be able to use Brupop. In particular, Brupop uses a public endpoint, `updates.bottlerocket.aws`, to get the TUF metadata. It may or may not be acceptable in your usecase to punch a small hole in your firewall to access that public endpoint. There is a good [discussion on this topic in the Brupop repository](https://github.com/bottlerocket-os/bottlerocket-update-operator/pull/387). In this case, if you are using EKS, you can use the EKS Console or `eksctl` to update your Bottlerocket nodes as discussed below.

##### How do I use brupop?

#### EKS

When running the `aws-k8s-*` variants of Bottlerocket on EKS, you can use either the EKS Console or `eksctl` to update your Bottlerocket nodes.

##### EKS Console

##### `eksctl`

### SSM

#### SSM Automation Documents

## Locking To A Specific Release

### ECS

### Kubernetes
