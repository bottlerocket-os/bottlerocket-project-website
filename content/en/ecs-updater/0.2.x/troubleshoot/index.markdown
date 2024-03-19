+++
title = "Troubleshoot"
type = "docs"
description = "Debugging and solving ECS Updater problems" 
weight = 30
+++

Troubleshooting’s first step is evaluating the log messages emitted by ECS Updater.
See Operate & Observe for details on how logging works with ECS Updater and what common messages mean.

## Common Issues

### Bottlerocket instances start with an old version of Bottlerocket

After using ECS Updater for a while you may notice that any brand new nodes added to the cluster start with an older version of Bottlerocket then ECS Updater flags them for an update on next invocation.
The ECS updater can only update existing nodes and it doesn’t manage the node creation process.
If you’re using an auto-scaling group, update your AMI ID in the the launch configuration or template.

### Spot instances never update to a new version of Bottlerocket

While it’s possible to run ECS Updater in conjunction with [Amazon EC2 Spot](https://aws.amazon.com/ec2/spot/), in practice **this doesn’t work well**.
Due to the short average lifespan of Spot instances paired with the run frequency and draining requirements in ECS Updater, Spot instances are unlikely to be kept up-to-date.
If you intend to use Spot instances, set the instance to start with the latest AMI for your variant.

### Stuck Updates

ECS Updater attempts to update nodes with minimal disruption to your workloads, however it must balance this with the reboot needed to complete the update.
To update a node, it requires a number of preconditions:

1. The node has non-service task.
ECS Updater will avoid updating any node that has un-replacable workloads.
<br> **Troubleshooting step**: Confirm the workloads on the node that did not update are part of services.
2. The cluster lacks spare capacity.
Amazon ECS needs to replace any tasks shut down by attempting to update whilst maintaining a service’s `minimumHealthyPercent` configuration.
ECS will not stop tasks that violate this configuration and consequently, the node will not drain.
<br> **Troubleshooting step**: Check that your `minimumHealthyPercent`  is reasonable and that you have enough capacity to adequately update nodes.
3. Draining takes too long.
ECS Updater waits for the ECS control plane to drain a node for 25 minutes.
<br> **Troubleshooting step:** Ensure that your workloads respond as quickly as possible to `SIGTERM` , evaluate the `stopTimeout`  value in the task definition, and evaluate the load balancer health check and deregistration delays.

## Also see:

* [Bottlerocket FAQ](/en/faq)
    * [Why do some of the nodes in my cluster have an update available and others do not?](/en/faq/#7_3)
    * [Why are my nodes egressing to `updates.bottlerocket.aws`?](/en/faq/#7_2)
