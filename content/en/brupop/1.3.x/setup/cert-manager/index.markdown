+++
title = "Prerequisite: cert-manager"
type = "docs"
description = "Prepare your cluster for Brupop" 
weight = 1
+++

Brupop uses [cert-manager](https://cert-manager.io/) to manage self-signed certificates.
You can install it with `kubectl` or [helm](https://helm.sh/).

{{% alert title="Note" color="success" %}}
This guide uses the most recent release of `cert-manager`, {{< brupop/cert-manager-version >}}, but there is no particular hard dependency on this version.
{{% /alert %}}

## Installing `cert-manager` using `kubectl`

Use `kubectl` to install cert-manager:

```shell
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v{{< brupop/cert-manager-version >}}/cert-manager.yaml
```

## Installing `cert-manager` using `helm`

First, add the `cert-manager` helm chart:

```shell
helm repo add jetstack https://charts.jetstack.io
```

Then update your local chart:

```shell
helm repo update
```

Finally, install `cert-manager` including its CRDs:

```shell
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v{{< brupop/cert-manager-version >}} \
  --set installCRDs=true
```

## Next step

After installing `cert-manager`, go ahead and [install Brupop itself](../install/).
