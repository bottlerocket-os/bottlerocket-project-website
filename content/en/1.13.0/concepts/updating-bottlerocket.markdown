# Updating Bottlerocket

## 1. Ways To Launch

### AWS ECS

?

### AWS EKS/Kubernetes

#### Managed Node Groups

#### Karpenter

#### Terraform

## 1. Ways To Update

### AWS ECS

https://github.com/bottlerocket-os/bottlerocket-ecs-updater#how-it-works

### AWS EKS/Kubernetes

#### Safe and Convenient: Brupop

##### What is Brupop?

The **B**ottle**r**ocket **up**date **op**erator (Brupop) is a [Kubernetes Operator](https://kubernetes.io/docs/concepts/extend-Kubernetes/operator/) that manages the Bottlerocket update process for you. It is designed to be a simple, safe, and convenient way to update your Bottlerocket nodes. To read more about the design of Brupop, see the [Brupop deep dive design document](https://github.com/bottlerocket-os/bottlerocket-update-operator/blob/develop/design/1.0.0-release.md).

##### Why should I use Brupop?

##### When would I use Brupop?

##### How do I use brupop?

#### Easiest: node replacement via EKS GUI/`eksctl`

### Both ECS and EKS/Kubernetes

#### Manual: in-place updates via SSM Automation Documents

## 1. Locking To A Specific Release

### AWS ECS

### AWS EKS/Kubernetes
