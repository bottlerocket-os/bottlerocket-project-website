+++
title = "Configure Brupop"
type = "docs"
description = "Making the operator work for your needs" 
weight = 30
+++


When you install Brupop, the operator comes pre-configured with reasonable defaults.
[Labeling your nodes](#label-nodes) is the only required configuration step.

## Required Configuration

### Label nodes

{{% alert title="Warning" color="warning" %}}
You can fully install Brupop but if you do not apply the proper node labels the operator will not your update nodes.
{{% /alert %}}

[Kubernetes node labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) controls which nodes Brupop updates;
specfically, the label `bottlerocket.aws/updater-interface-version=2.0.0` dictactes which nodes in the cluster get automatic updates.

You can label nodes using {{< cross-project-current-link url="/en/os/x.x.x/api/settings/kubernetes/#node-labels" project="os" >}}`settings.kubernetes.node-labels`{{</ cross-project-current-link>}} with TOML (including instance user data), using `apiclient` in a host container, or `kubectl`:

#### `apiclient`

```shell
apiclient set settings.kubernetes.node-labels.bottlerocket.aws/updater-interface-version=2.0.0
```

#### `eksctl`

```yaml
...
nodeGroups:
  - name: name-of-your-nodegroup
    labels: { bottlerocket.aws/updater-interface-version: 2.0.0 }
...
```

#### `kubectl`

```shell
# replace MY_NODE_NAME with the name of your node
kubectl label node MY_NODE_NAME bottlerocket.aws/updater-interface-version=2.0.0
```

##### Label all nodes

If you are running Bottlerocket on all nodes in your cluster, you can use `kubectl` to label all nodes at once:

```shell
kubectl label node $(kubectl get nodes -o jsonpath='{.items[*].metadata.name}') bottlerocket.aws/updater-interface-version=2.0.0
```

#### TOML / User Data

```TOML
...
[settings.kubernetes.node-labels]
"bottlerocket.aws/updater-interface-version" = 2.0.0
...
```

## Optional Configuration

### Scheduling

Brupop schedules node updates based a cron expression in the following format:

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

#### Helm

You can configure the schedule with `scheduler_cron_expression`.

#### Kubernetes YAML

In the controller deployment, you can change the schedule by alerting the `env` named `SCHEDULER_CRON_EXPRESSION` to the desired cron expression `value`.
See {{% github-at-commit repo="bottlerocket-os/bottlerocket-update-operator"  path="/deploy/charts/bottlerocket-update-operator/templates/controller-deployment.yaml" %}}`controller-deployment.yaml`{{% /github-at-commit %}} for more details on the stuctures.

---

### Concurrent Updates

You can set the maximum concurrency of updates that Brupop will perform.
You either set a specific number of concurrent updates or, alternately, `"unlimited"` to update as many nodes as possible concurrently.
In either case, Brupop always respects [PodDisruptionBudgets](https://kubernetes.io/docs/tasks/run-application/configure-pdb/).

{{% alert title="Conflicts between load balancing and concurrency" color="warning" %}}
Take caution when setting concurrency and excluding load balancers together, as misconfiguration can result in a condition where all nodes exclude load balancing.
{{% /alert %}}

#### Helm

You can configure the concurrency by `max_concurrent_updates` .

#### Kubernetes YAML

In the controller deployment, you can change the schedule by alerting the `env` named `SCHEDULER_CRON_EXPRESSION` to the desired `value`.
See {{% github-at-commit repo="bottlerocket-os/bottlerocket-update-operator"  path="/deploy/charts/bottlerocket-update-operator/templates/controller-deployment.yaml" %}}`controller-deployment.yaml`{{% /github-at-commit %}} for more details on the stuctures.

---

### API Server Ports

By default, the operator's API server uses port `8443` for internal traffic and port `443` for node agents, but you can change these ports via configuration.
Both ports must be set or the operator will fail to start.

#### Helm

You can configure the API server ports by changing the value of `apiserver_internal_port` for internal traffic and `apiserver_service_port` for node agent traffic.

#### Kubernetes YAML

If configuring Brupop via Kubernetes YAML, you need to change the port values in several places, see {{% github-at-commit repo="bottlerocket-os/bottlerocket-update-operator"  path="/bottlerocket-update-operator.yaml" %}}pre-baked YAML manifest{{% /github-at-commit %}} and the following templates for more details on the structures:

- `{{< github-at-commit repo="bottlerocket-os/bottlerocket-update-operator"  path="/deploy/charts/bottlerocket-shadow/templates/custom-resource-definition.yaml" >}}custom-resource-definition.yaml{{< /github-at-commit >}}`
- `{{< github-at-commit repo="bottlerocket-os/bottlerocket-update-operator"  path="/deploy/charts/bottlerocket-update-operator/templates/api-server-service.yaml" >}}api-server-service.yaml{{< /github-at-commit >}}`
- `{{< github-at-commit repo="bottlerocket-os/bottlerocket-update-operator"  path="/deploy/charts/bottlerocket-update-operator/templates/agent-daemonset.yaml" >}}agent-daemonset.yaml{{< /github-at-commit >}}`
- `{{< github-at-commit repo="bottlerocket-os/bottlerocket-update-operator"  path="/deploy/charts/bottlerocket-update-operator/templates/api-server-deployment.yaml" >}}api-server-deployment.yam{{< /github-at-commit >}}`

---

### Logging

Brupop emits logs from the controller, agent, and API server through standard Kubernetes logging mechanisms but you configure the log format and filter.

Log formatting has four options:

- `full`: Human-readable, single-line logs,
- `compact`: A shorter version of `full`,
- `pretty`: "Excessively pretty", terminal-optimized human-readable logs (default),
- `json`: New line-delimited JSON-formatted (machine-readable) logs.

You can optionally set the logs to add ANSI colour information, which is helpful if viewing in a terminal, but adds garbage characters for non-terminal logging utilities.

Log filtering accepts on both typical log levels (`info` (default), `debug`, `error`) or through [filter directives](https://docs.rs/tracing-subscriber/0.3.17/tracing_subscriber/filter/struct.EnvFilter.html#directives).

#### Helm

You can configure the log format with `logging.formatter` and ANSI color with `logging.ansi_enabled` (`true`/`false`).

To change the log filtering, set the `logging.controller.tracing_filter`, `logging.agent.tracing_filter`, and `logging.apiserver.tracing_filter` to the desired log level or filter directive.

#### Kubernetes YAML

You need to configure the logging seperately for each item seperately, see the following templates:

- API Server: `{{< github-at-commit repo="bottlerocket-os/bottlerocket-update-operator"  path="/deploy/charts/bottlerocket-update-operator/templates/api-server-deployment.yaml" >}}api-server-deployment.yaml{{< /github-at-commit >}}`
- 

To configure the format of your logs with, you need to change the `env` named `LOGGING_FORMATTER` to the desired format option.
