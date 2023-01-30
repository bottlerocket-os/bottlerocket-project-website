# Updating Bottlerocket

## Introduction

Bottlerocket is designed to be updated in an [image-based fashion](https://github.com/bottlerocket-os/bottlerocket#updates). This means that updates are applied by replacing the entire image on disk, rather than applying a series of individual package updates. This is a departure from the traditional package-based Linux update model such as `apt` or `yum`, which are what you would find in Ubuntu or Amazon Linux.

## Ways To Update

There are a few ways to update Bottlerocket. The method you choose depends on the [Bottlerocket variant](https://github.com/bottlerocket-os/bottlerocket#variants) you are using and your environment.

### ECS

For the `aws-ecs-*` variants of Bottlerocket, we provide an [ECS updater](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#how-it-works). Please see the [ECS updater installation documentation](https://github.com/bottlerocket-os/bottlerocket-ecs-updater#installation) for more information on how to install and use the ECS updater.

### Kubernetes

For the `aws-k8s-*` variants of Bottlerocket, there are a few possible ways to update Bottlerocket. The recommended method is to use Brupop, however there are alternatives in case you do not want to use Brupop.

#### Brupop

This is the recommended method to update Bottlerocket on Kubernetes. The following sections should help you understand why, when, and how to use Brupop.

##### What is Brupop?

The **B**ottle**r**ocket **up**date **op**erator (Brupop) is a [Kubernetes Operator](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/) that manages the Bottlerocket update process for you. It is designed to be a simple, safe, and convenient way to update your Bottlerocket nodes. To read more about the design of Brupop, see the [Brupop deep dive design document](https://github.com/bottlerocket-os/bottlerocket-update-operator/blob/develop/design/1.0.0-release.md).

##### Why should I use Brupop?

##### When would I use Brupop?

##### How do I use brupop?

#### EKS

##### EKS Console

##### `eksctl`

### SSM

#### SSM Automation Documents

## Locking To A Specific Release

### ECS

### Kubernetes
