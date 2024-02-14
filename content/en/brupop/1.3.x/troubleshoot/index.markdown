+++
type = "docs"
title = "Troubleshoot"
weight = 30
description = "Debugging and solving Brupop problems"
+++

## Debugging information

Brupop’s components emit useful logs for debugging and troubleshooting.

### API Server deployment logs

Searching through the API Server’s deployment logs for a particular Node ID will yield the mutations to the node.
Assuming the default namespace you can retrieve these by running:

```shell
kubectl logs deployment/brupop-apiserver --namespace brupop-bottlerocket-aws 
```

### Agent logs

Logs from the agent show the specific update actions taken on a particular node.

First, find the node in the list of the Brupop agent pods (assuming the default namespace):

```shell
kubectl get pods --selector=brupop.bottlerocket.aws/component=agent -o wide --namespace brupop-bottlerocket-aws
```

From this list get the logs for the agent you’re troubleshooting by replacing `<agent-podname>` with the node name from the previous step.

```shell
kubectl logs <agent-podname> --namespace brupop-bottlerocket-aws 
```

## Common Issues

### Stuck Updates

When one or more nodes do not progress through the states and return to idle it is a "stuck update." By default, Brupop only updates one node so a single node can prevent nodes across the cluster from updating.

There are a few potential causes of stuck updates:

1. Pod Disruption Budget preventing a node drain.
Brupop uses the Kubernetes Eviction API to drain pods from a node.
It’s possible to have Pod Disruption Budgets configured (often mistakenly) to disallow a pod removal resulting in a un-drainable node that Brupop cannot update.  
    **Troubleshooting step:** Check your pod disruption budget configuration.
2. Unable to access `updates.bottlerocket.aws`.
Bottlerocket needs to access metadata from a public endpoint to get information about the most recent release.
Production environments may limit this type of outbound access.  
**Troubleshooting step:** Log into the control container of a node and run `apiclient update check`.
Failures with this check indicate an outbound block.  
**Potential solution:** Scrape the contents of `updates.bottlerocket.aws` with [`Tuftool`](https://github.com/awslabs/tough/tree/develop/tuftool#download-tuf-repo) and serve from within your cluster, then update your settings accordingly for {{< setting-reference setting="settings.updates.metadata-base-url" current_version="true">}}settings.updates.metadata-base-url{{</ setting-reference >}}  and {{< setting-reference setting="settings.updates.targets-base-url" current_version="true">}}settings.updates.targets-base-url{{</ setting-reference >}}.

3. Other issues while updating.  
**Troubleshooting step:** Check the agent logs for the stuck node.

### Bottlerocket instances start with an old version of Bottlerocket

After using Brupop for a while you may notice that any brand new nodes added to the cluster start with an older version of Bottlerocket then Brupop flags them for an update almost immediately.
Brupop can only update existing nodes and it doesn’t manage the node creation process.
Depending on how you created your nodes determines how to address this issue:

* **Auto-scaling group**: update your AMI ID in the launch configuration or template.
* **Manual creation of nodes with AWS CLI**: Update the `image-id` argument to the latest AMI ID
* **VMware**: Change the `target-name` argument when downloading the OVA with tuftool

## Related

* [Bottlerocket FAQ](/en/faq)
    - [Why do some of the nodes in my cluster have an update available and others do not?](/en/faq/#7_3)
    - [Why are my nodes egressing to `updates.bottlerocket.aws`?](/en/faq/#7_2)
* [Log Configuration](../setup/configure/#logging)
