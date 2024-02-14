+++
type = "docs"
title = "Disable/Uninstall"
weight = 90
description = "Removing Brupop from nodes or your cluster"
+++

You can disable Brupop from managing some or all nodes of your cluster as well as fully remove it from your cluster.

## Disabling Brupop on nodes

Brupop will only manage updates for the nodes you’ve labeled `bottlerocket.aws/updater-interface-version=2.0.0`.
Consequently, if you remove the label, Brupop will no longer manage the node updates.
See the [Kubectl `label` docs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#label) for more information on removing a label.

## Uninstalling Brupop

To fully remove Brupop from your cluster, execute the following [helm](https://helm.sh/) uninstall operations on your cluster:

```shell
helm uninstall brupop
helm uninstall brupop-crd
```
