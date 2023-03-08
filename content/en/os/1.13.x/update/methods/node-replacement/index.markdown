+++
title = "Node Replacement"
type = "docs"
description = "How to update a Bottlerocket cluster by replacing nodes"
+++

Bottlerocket clusters can be updated via node replacement, meaning that the existing Bottlerocket nodes will be replaced by new Bottlerocket nodes that run updated software.
This requires nodes to be reprovisioned.

## EKS

When running the `aws-k8s-*` variants of Bottlerocket on EKS, use either the EKS Console or [`eksctl`](https://eksctl.io/) to update your Bottlerocket nodes using the _node replacement_ method.
This means that you are replacing your existing Bottlerocket nodes with new Bottlerocket nodes, rather than updating your existing Bottlerocket nodes in-place.

### EKS Console

In order to update your Bottlerocket nodes in an EKS cluster using the EKS Console, follow the [steps found under the "AWS Management Console" tab, in the EKS User Guide](https://docs.aws.amazon.com/eks/latest/userguide/update-managed-node-group.html#mng-update).

### `eksctl`

Using [`eksctl`](https://eksctl.io/) is another option to update your Bottlerocket nodes.
Specific commands can be found in the [EKS User Guide: "Update a node group version", on the `eksctl` tab](https://docs.aws.amazon.com/eks/latest/userguide/update-managed-node-group.html#mng-update).
