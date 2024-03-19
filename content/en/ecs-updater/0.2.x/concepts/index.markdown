+++
title = "Concepts"
type = "docs"
description = "Introduction to the components and concepts used in the Bottlerocket ECS Updater" 
weight = 1
+++

You can update Bottlerocket in a couple of ways:

* **node replacement** where new instances with a new version of the OS replace nodes with older versions of the OS,
* **in-place updates** where the node downloads and reboots into a new version of the OS while maintaining the same instance/machine.

There is no single preferred nor advised method to update a node; both methods have pros and cons depending on your situation.
You can trigger an {{< cross-project-current-link project="os" url="/en/os/x.x.x/update/methods/in-place/#apiclient-commands">}}in-place update manually with the API{{< /cross-project-current-link >}} or you can use the Bottlerocket ECS Updater.
**The ECS Updater is a service that checks for (and applies) Bottlerocket updates when your nodes are ready.**

If you use Bottlerocket on Kubernetes (see [Brupop](../../brupop/)) or intend to replace nodes in [Amazon ECS](https://aws.amazon.com/ecs/), ECS Updater is not for you.
If you plan to use [EC2 Spot in your ECS cluster](../troubleshoot/#spot-instances-never-update-to-a-new-version-of-bottlerocket), ECS Updater is not for you.
Even if you do plan to do in-place updates, you don’t need to use ECS Updater as you can manage in-place updates in other ways.
However, ECS updater offers an automated way to manage in-place Bottlerocket updates.

## Overview

The ECS Updater periodically evaluates data from the ECS control plane API and information from each Bottlerocket node’s API server to determine what nodes need an update *and* which nodes are eligible for replacement.
The upgradable, eligible nodes drain, reboot into the latest update, and finally reactivate.

## Automated updates

The ECS Updater task runs from [AWS Fargate](https://aws.amazon.com/fargate/), triggered periodically by [Amazon EventBridge](https://aws.amazon.com/eventbridge/).
The updater task first determines the Bottlerocket nodes in a given cluster by querying the ECS API.

{{< ecs-updater/eventbridge-api-task >}}

Next, the ECS Updater runs an [AWS Systems Manager](https://aws.amazon.com/systems-manager/) [(SSM) Document](https://docs.aws.amazon.com/systems-manager/latest/userguide/documents.html) on each Bottlerocket node against the control container.
This document invokes the API Client to check for updates.
With the list of nodes that have available updates, the ECS Updater task queries the ECS API for information on the type of workloads running on the node.
If a node is running one or more non-service ([standalone](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/standalone-tasks.html) or [scheduled](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/scheduling_tasks.html)) tasks, the node is deemed not updateable.

{{< ecs-updater/updateable >}}

ECS Updater uses the ECS API to initiate node draining and checks the number of running tasks on the node until none remain.

{{< ecs-updater/node-3-ready >}}

Once the node has no remaining tasks, the ECS Updater runs an SSM Document against the control container to initiate the update through the {{< cross-project-current-link project="os" url="/en/os/x.x.x/concepts/api-driven/">}}Bottlerocket API{{</ cross-project-current-link >}}.

Effectively, this is the same as running  `apiclient update apply --reboot`  from an interactive SSM session with the control container.
After the reboot, the node will be running the newer version of Bottlerocket.

{{< ecs-updater/drain-ssm >}}

Once confirmed to be running with the new version, the ECS Updater uses the ECS API to update the node status to active.
At this point ECS will resume assigning tasks to the updated node.

{{< ecs-updater/node-ready-for-tasks >}}
