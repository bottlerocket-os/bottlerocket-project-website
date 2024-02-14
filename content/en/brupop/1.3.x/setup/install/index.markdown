+++
title = "Install Brupop"
type = "docs"
description = "Install the Bottlerocket Update Operator on your Kubernetes cluster" 
weight = 10
+++

Installing Brupop creates the custom resource definitions (CRDs), roles, and deployments and uses the latest operator image from [Amazon ECR Public](https://gallery.ecr.aws/bottlerocket/bottlerocket-update-operator).

You can install Brupop either [with `helm`](#install-with-helm) or a [pre-baked manifest](#install-with-a-manifest).

## Install with `helm`

First, using [helm](https://helm.sh/) add the `bottlerocket-operator-chart`

```shell
helm repo add brupop https://bottlerocket-os.github.io/bottlerocket-update-operator
```

Then update your local chart:

```shell
helm repo update
```

Create a namespace for the operator:

```shell
kubectl create namespace brupop-bottlerocket-aws
```

Next, install the Brupop custom resource definition:

```shell
helm install brupop-crd brupop/bottlerocket-shadow
```

Finally, install the operator itself:

```shell
helm install brupop-operator brupop/bottlerocket-update-operator
```

After you've installed the operator, you can move on to the next step: [configuring Brupop](../configure/).

## Install with a Manifest

First, <a href="https://github.com/bottlerocket-os/bottlerocket-update-operator/releases/tag/v{{< current-version project="brupop" >}}">download the manifest from the release</a> to your local machine and run the following:

```shell
kubectl apply -f bottlerocket-update-operator-v{{< current-version project="brupop" >}}.yaml
```

Alternately, you can point `kubectl` directly at the manifest URL.

```shell
kubectl apply -f https://github.com/bottlerocket-os/bottlerocket-update-operator/releases/download/v{{< current-version project="brupop" >}}/bottlerocket-update-operator-v{{< current-version project="brupop" >}}.yaml
```

After you've installed the operator, you can move on to the next step: [configuring Brupop](../configure/).
