+++
type="docs"
title="Operate & Observe"
weight=10
+++

After installation on your cluster Brupop runs in the background and generally requires no intervention.
Your nodes will check for updates and apply them according your configuration and the Bottlerocket update waves.

However, you can observe the status of the updates by [adhoc query](#adhoc-query) or setup [on-going monitoring](#on-going-monitoring).

## Adhoc Query

If you want to see the update status of your nodes, use `kubectl` to get the custom resource `brs` :

```shell
kubectl get brs --namespace brupop-bottlerocket-aws
```

`kubectl` returns the [state](../concepts/#states), current version, target state, and target version. For example:

```shell
AME                                               STATE   VERSION     TARGET STATE   TARGET VERSION
brs-node-1                                         Idle    1.17.0     Idle           
brs-node-2                                         Idle    1.17.0     StagedUpdate   1.18.0
```

## On-going monitoring

To facilitate on-going monitoring the Brupop API server and controller provide you with metrics endpoints (`/metrics`) compatible with [Prometheus](https://prometheus.io/).
The metrics endpoints expose two metrics: one that describes the current version of each node (`brupop_hosts_version`) and another for the [state](../concepts/#states) of each node (`brupop_hosts_state`).

For a sample configuration of using Prometheus with Brupop see the [configuration on the Brupop GitHub Repo](#).
Additionally, [Containers On AWS has a step-by-step walkthrough](#) using EKS, Brupop, and Prometheus.
