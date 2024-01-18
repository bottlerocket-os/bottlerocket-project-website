+++
title = "Prerequisite: cert-manager"
type = "docs"
description = "Prepare your cluster for Brupop" 
weight = 1
+++

Brupop uses [cert-manager](https://cert-manager.io/) to manage self-signed certificates. You can install it with `kubectl` or `helm`.

## Installing `cert-manager` using `kubectl`

You can use `kubectl` to install cert-manager:

```shell
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.2/cert-manager.yaml
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
  --version v1.8.2 \
  --set installCRDs=true
```

## Next step

After installing `cert-manager`, go ahead and [install Brupop itself](../install/).
