+++
title = "Configure Brupop"
type = "docs"
description = "Making the operator work for your needs" 
weight = 30
+++

When you install Brupop, the operator comes pre-configured with reasonable defaults.
[Labeling your nodes](#label-nodes) is the only required configuration step.

Aside from labeling nodes, you configure Brupop with [helm](https://helm.sh/) or with a manifest.
Helm reduces the configuration burden for Brupop substantially with few down sides, so this documentation focuses on configuration with helm.
If you choose to not use helm, refer to the {{< github-link-at-version url="https://github.com/bottlerocket-os/bottlerocket-update-operator/blob/vx.x.x/bottlerocket-update-operator.yaml" project="brupop" >}}pre-baked manifest for an example{{< /github-link-at-version >}}.

## Required Configuration

### Label nodes

{{% alert title="Warning" color="warning" %}}
You can fully install Brupop but if you do not apply the proper node labels the operator will not update your nodes.
{{% /alert %}}

[Kubernetes node labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) control which nodes Brupop updates; specifically, the label `bottlerocket.aws/updater-interface-version=2.0.0` dictates which nodes in the cluster get automatic updates.

You can label nodes using {{< cross-project-current-link url="/en/os/x.x.x/api/settings/kubernetes/#node-labels" >}}`settings.kubernetes.node-labels`{{</ cross-project-current-link>}} with TOML {{< cross-project-current-link url="/en/os/x.x.x/concepts/api-driven/#user-data" >}}(including instance user data){{</ cross-project-current-link>}}, using `apiclient` in a host container, or `kubectl`.

#### Label a node with `apiclient`

From the control or admin container, run the following:

```shell
apiclient set settings.kubernetes.node-labels.bottlerocket.aws/updater-interface-version=2.0.0
```

#### Label all nodes when starting an EKS cluster with `eksctl`

```yaml
...
nodeGroups:
  - name: name-of-your-nodegroup
    labels: { bottlerocket.aws/updater-interface-version: 2.0.0 }
...
```

#### Labeling nodes with `kubectl`

#### Label a single node

```shell
# replace MY_NODE_NAME with the name of your node
kubectl label node MY_NODE_NAME bottlerocket.aws/updater-interface-version=2.0.0
```

##### Label all nodes

If you are running Bottlerocket on all nodes in your cluster, you can use `kubectl` to label all nodes at once:

```shell
kubectl label node $(kubectl get nodes -o jsonpath='{.items[*].metadata.name}') bottlerocket.aws/updater-interface-version=2.0.0
```

#### Labeling a node with the Bottlerocket API

Add the following TOML to your instance user data:

```TOML
...
[settings.kubernetes.node-labels]
"bottlerocket.aws/updater-interface-version" = "2.0.0"
...
```

## Optional Configuration

### API Server Ports

__Helm Configuration__: `apiserver_internal_port` for internal traffic, `apiserver_service_port` for node agent traffic.

Brupop uses two ports for [communication between components](../../concepts/#controlled-updates): `apiserver_internal_port` for the controller and the [`BottlerocketShadow` custom resource](../../concepts/#states) and the `apiserver_service_port` for the conversion webhook.
Refer to the the
{{< github-link-at-version project="brupop" url="https://github.com/bottlerocket-os/bottlerocket-update-operator/blob/vx.x.x/bottlerocket-update-operator.yaml">}} manifest {{< / github-link-at-version >}} for more information on the usage of each port.

By default, the operator’s API server uses port `8443` for internal traffic and port `443` for node agents, but you can change these ports via this configuration.
Both ports must be set or the operator will fail to start.

Example:

```YAML
apiserver_internal_port: "8443"
```

---

### Concurrent Updates

__Helm Configuration__: `max_concurrent_updates`

You can set the maximum concurrency of updates that Brupop will perform.
You either set a specific number of concurrent updates or, alternately, `"unlimited"` to update as many nodes as possible concurrently.
In either case, Brupop always respects [`PodDisruptionBudget`](https://kubernetes.io/docs/tasks/run-application/configure-pdb/).

{{% alert title="Conflicts between load balancing and concurrency" color="warning" %}}
Take caution when setting concurrency and [excluding load balancers](#load-balancer-exclusion) together, as misconfiguration can result in a condition where all nodes exclude load balancing and can never drain fully to complete the update.
Setting up `PodDisruptionBudget` guards against this condition.
{{% /alert %}}

Example:

```yaml
max_concurrent_updates: "1"
```

---

### Namespace

__Helm Configuration__: `brupop-bottlerocket-aws`

You can change the namespace where Kubernetes deploys Brupop (default: `brupop-bottlerocket-aws`).

Example:

```yaml
namespace: "brupop-bottlerocket-aws"
```

---

### Load balancer exclusion

__Helm Configuration__: `exclude_from_lb_wait_time_in_sec`

With this option, you control the exclusion of the node from load balancing and delays draining the node for the number of seconds specified.
Internally, Brupop uses [`node.kubernetes.io/exclude-from-external-load-balancers`](https://kubernetes.io/docs/reference/labels-annotations-taints/#node-kubernetes-io-exclude-from-external-load-balancers) to exclude the node from load balancing.

See [Concurrent Updates](#concurrent-updates) for an important warning about concurrency and load balancer exclusion.

Example:

```yaml
exclude_from_lb_wait_time_in_sec: "0"
```

---

### Logging

Brupop emits logs from the controller, agent, and API server through standard Kubernetes logging mechanisms but you configure the log format and filter.

#### Format

__Helm Configuration__: `logging.formatter`

Log formatting has four options:

- `full`: Human-readable, single-line logs,
- `compact`: A shorter version of `full`,
- `pretty`: "Excessively pretty", terminal-optimized human-readable logs (default),
- `json`:  New line-delimited JSON-formatted (machine-readable) logs.

Example:

```yaml
logging:
  formatter: "pretty"
```

#### Colours

__Helm Configuration__: `logging.ansi_enabled`

You can optionally set the logs to add ANSI colour information (`true`/`false`), which is helpful if viewing in a terminal, but adds garbage characters for non-terminal logging utilities.

Example:

```yaml
logging:
  ansi_enabled: "true"
```

#### Filter

__Helm Configuration__: The controller, agent, and API server are configured via`logging.controller.tracing_filter`, `logging.agent.tracing_filter`, and `logging.apiserver.tracing_filter` (respectively).

Log filtering accepts on both typical log levels (`info` (default), `debug`, `error`) or through [filter directives](https://docs.rs/tracing-subscriber/0.3.17/tracing_subscriber/filter/struct.EnvFilter.html#directives).

Example:

```yaml
 controller:
    tracing_filter: "info"
  agent:
    tracing_filter: "debug"
  apiserver:
    tracing_filter: "error"
```

---

### Placement

__Helm Configuration__: `placement.agent`, `placement.controller`, `placement.apiserver`

With these configurations, you can control the [tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) for the agent, controller and API server.
For the controller and API server you can also control the [node selector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector), and [pod affinitiy and anti-affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity).

Example:

```yaml
# Placement controls
# See the Kubernetes documentation about placement controls for more details:
# * https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/
# * https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector
# * https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity
placement:
  agent:
    # The agent is a daemonset, so the only controls that apply to it are tolerations.
    tolerations: []

  controller:
    tolerations: []
    nodeSelector: {}
    podAffinity: {}
    podAntiAffinity: {}

  apiserver:
    tolerations: []
    nodeSelector: {}
    podAffinity: {}
    # By default, apiserver pods prefer not to be scheduled to the same node.
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
        - weight: 1
          podAffinityTerm:
            labelSelector:
              matchExpressions:
              - key: brupop.bottlerocket.aws/component
                operator: In
                values:
                - apiserver
            topologyKey: kubernetes.io/hostname
```

---

### Private Image Registry

__Helm Configuration__: `image_pull_secrets`

If you are testing Brupop with a private image registry, you can configure pull secrets to fetch images.

Example:

```yaml
image_pull_secrets:
  - name: "brupop"
```

---

### Scheduling

__Helm Configuration__: `scheduler_cron_expression`

Brupop schedules node updates based on a cron expression in the following format:

```text
 ┌───────────── seconds (0 - 59)
 │ ┌───────────── minute (0 - 59)
 │ │ ┌───────────── hour (0 - 23)
 │ │ │ ┌───────────── day of the month (1 - 31)
 │ │ │ │ ┌───────────── month (Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec)
 │ │ │ │ │ ┌───────────── day of the week (Mon, Tue, Wed, Thu, Fri, Sat, Sun)
 │ │ │ │ │ │ ┌───────────── year (formatted as YYYY)
 │ │ │ │ │ │ │
 │ │ │ │ │ │ │
 * * * * * * *
```

Example:

```yaml
# Every day at 3 AM
scheduler_cron_expression: "* * 3 * * * *"
```
