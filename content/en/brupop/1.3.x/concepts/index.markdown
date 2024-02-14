+++
title = "Concepts"
type = "docs"
description = "Introduction to the components and concepts used in Brupop" 
weight = 1
+++

You can update Bottlerocket in a couple of ways:

* **node replacement** where new instances with a new version of the OS replace nodes with older versions of the OS,
* **in-place updates** where the node downloads and reboots into a new version of the OS while maintaining the same instance/machine.

There is no single preferred nor advised method to update a node; both methods have pros and cons depending on your situation.

You can trigger an {{< cross-project-current-link project="os" url="/en/os/x.x.x/update/methods/in-place/#apiclient-commands">}}in-place update manually with the API{{< /cross-project-current-link >}} or you can use the Bottlerocket Update Operator (Brupop).
**Brupop is a Kubernetes operator for managing in-place updates of Bottlerocket on Kubernetes.**

If you use Bottlerocket on ECS or intend to replace nodes in Kubernetes, Brupop is not for you.
Even if you do plan to do in-place updates Brupop is not required as you can manage in-place updates in other ways.
However, Brupop offers a declarative, automated way to manage in-place Bottlerocket updates.

## Controlled updates

Brupop uses the [Kubernetes controller pattern](https://kubernetes.io/docs/concepts/architecture/controller/) in an effort to safely update all the nodes whilst minimizing disruptions to workloads.
To achieve this, Brupop does the following:

* Controls the rate and flow of updates across the entire cluster,
* First prevents new workloads from being scheduled to the node then drains existing workloads prior to updates,
* Contains and prevents the propagation of update problems when the controller detects update failures.

{{< brupop/components-diagram >}}

Brupop collects the state of each node with an agent.
The Brupop Agent runs in a container on each node as a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/).
This agent sends the state to an API Server.
API Server instances run in the cluster itself and communicates with the Kubernetes API to record the state as a custom resource.

{{< brupop/agent-api-server-control-plane >}}

{{< alert title="Bottlerocket API Server vs Brupop API Server?" color="success" >}}
Don’t confuse Bottlerocket’s {{< cross-project-current-link project="os" url="/en/os/x.x.x/concepts/api-driven/">}}API Server{{< /cross-project-current-link >}} with Brupop’s API Server, these are two distinct things, just with the same name.
In this part of the documentation, unless otherwise noted, assume that “API Server” refers to the Brupop API Server.
{{< /alert >}}

The Controller also runs in a container on the cluster where it regularly evaluates the information about the state of each node and the cluster as a whole; based on this information it supplies instructions to the individual agents about update actions.

{{< brupop/agent-controller-diagram >}}

## States

At any given point nodes are in one of five Brupop states: **idle**, **staged & performed update**, **rebooted into update**, **monitoring update** or **error reset**.
A node is never in more than one state.
The state of each node is represented as a [Kubernetes Custom Resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) called a `BottlerocketShadow` resource or `brs`.

{{< brupop/state-machine >}}

### Idle

A node in the **idle** state does not have a pending update in-process.
Most of the time your nodes will remain in this state.

### Staged & Performed Update

{{< brupop/staged-and-performed >}}

Bottlerocket uses multiple partitions to manage in-place updates.
The OS runs from one partition and, when a new update is available, the update is downloaded and installed into the other.
The Brupop controller periodically requests the agent to check for and download the most recent version of Bottlerocket.
Once downloaded, Bottlerocket modifies the bootloader configuration to boot from the partition with the update and the agent changes the state to **Staged & Performed Update** with the Brupop API server.

### Reboot into Update

{{< brupop/reboot-into-update >}}

To minimize disruptions to the workloads running in the cluster, the controller signals to Kubernetes to prevent new workloads from being scheduled on to the node as well as shut down existing workloads (drain).
Once drained, the agent triggers a reboot into the new OS and changes the state to **Rebooted Into Update** with the Brupop API server.

### Monitoring Update

{{< brupop/monitoring >}}

Once the node reboots the update is technically complete, however the time whilst all your workloads startup is critical.
Bottlerocket’s versioning and variant scheme is built to mitigate incompatibilities between OS versions, there is always a chance that an unforeseen incompatibility exists with some component of your architecture.
Brupop’s state machine has a reserved state for monitoring these incompatibilities (**Monitoring Updates**), however as of this version, this state is a noop.
You can suggest a direction for this state on the [Brupop GitHub Repo](https://github.com/bottlerocket-os/bottlerocket-update-operator/issues/new?assignees=&labels=&projects=&template=issue.md&title=Suggestion%20for%20monitoring%20state).

Consequently, the Agent immediately transitions through **Monitoring Updates** back to **Idle** with the API server.

### Error Reset

In the situation that any of the above states fail, the state becomes **Error Reset** before transitioning back to **Idle**.
