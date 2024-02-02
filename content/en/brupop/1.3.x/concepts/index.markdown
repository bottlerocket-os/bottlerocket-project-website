+++
title = "Concepts"
type = "docs"
description = "Understanding Brupop" 
weight = 1
+++
---

## test

{{< brupop-agent-controller-diagram >}}
{{< brupop_agent_api_server_control_plane >}}
{{< brupop_components_diagram >}}

## Declarative, in-place updates

You can update Bottlerocket in a couple of ways:

* node replacement where new instances with a new version of the OS replace nodes with older versions of the OS,
* in-place updates where the node downloads a new version of the OS and reboots into a new version of the OS while maintaining the same instance.

There is no single preferred nor advised method to update a node; each method has pros and cons depending on your situation.

Bottlerocket Update Operator (Brupop) is a Kubernetes operator for managing in-place updates of Bottlerocket on Kubernetes. If you use Bottlerocket on ECS or intend to replace nodes in Kubernetes, Brupop is not for you. Even if you do plan to do in-place updates Brupop is not required as you can manage in-place updates in other ways. However, Brupop offers a declarative, automated way to manage in-place Bottlerocket updates.

## Controlled updates

Brupop uses the Kubernetes controller pattern in an effort to safely update all the nodes whilst minimizing disruptions to workloads. To achieve this, Brupop does the following:

* Controls the rate and flow of updates across the entire cluster,
* First prevents new workloads from being scheduled to the node then drains existing workloads prior to updates,
* Contains and prevents the propagation of update problems when the controller detects update failures.

Brupop collects the state of each node with an agent. The Brupop Agent runs in a container on each node as a DaemonSet. This agent sends the state to an API Server. The API Server runs in a container on the cluster itself and communicates with the Kubernetes API to record the state as a custom resource.

The Controller also runs in a container on the cluster where it regularly evaluates the information about the state of each node and the cluster as a whole; based on this information it supplies instructions to the individual agents about update actions.

## States

At any given point nodes are in one of five Brupop states: idle, staged & performed update, rebooted into update, monitoring update or error reset. A node is never in more than one state. The state of each node is represented as a Kubernetes Custom Resource called a BottlerocketShadow resource or brs.

### Idle

A node in the idle state does not have a pending update in-process. Most of the time your nodes will remain in this state.\

### Staged & Performed Update

Bottlerocket uses multiple partitions to manage in-place updates. The OS runs from one partition and, when a new update is available, the update is downloaded and installed into the other. The Brupop controller periodically requests the agent to check for and download the most recent version of Bottlerocket. Once downloaded, Bottlerocket modifies the bootloader configuration to boot from the partition with the update and the agent changes the state to Staged & Performed Update with the Brupop API server.

### Reboot into Update

To minimize disruptions to the workloads running in the cluster, the controller signals to Kubernetes to prevent new workloads from being scheduled on to the node as well as shut down existing workloads (drain). Once drained, the agent triggers a reboot into the new OS and changes the state to Rebooted Into Update with the Brupop API server.

### Monitoring Update

Once the node reboots the update is technically complete, however the time whilst all your workloads startup is critical. Bottlerocket’s versioning and variant scheme is built to mitigate incompatibilities between OS versions, there is always a chance that an unforeseen incompatibility exists with some component of your architecture. Typically, these incompatibilities become visible after the update occurs and during workload start. Consequently, Brupop waits before marking the node with the API server as fully complete, instead the agent sets the state to Monitoring Update with the API Server. This monitoring period prevents the cluster creating a situation where nodes update quickly but in an unhealthy state. Once the monitoring period completes, the Agent sets the state back to Idle with the API Server.

### Error Reset

In the situation that any of the above states fail, the state becomes Error Reset before transitioning back to Idle.
