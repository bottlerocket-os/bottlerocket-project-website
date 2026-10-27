+++
title = "K8s CIS Benchmark"
type = "docs"
description = "Generating a Kubernetes CIS Benchmark report"
toc_hide=true
+++

The [Kubernetes CIS Benchmark](https://www.cisecurity.org/benchmark/kubernetes) contains a number of security best practices to harden Kubernetes worker nodes.

{{% alert title="Note" color="success" %}}
The Kubernetes CIS Benchmark contains two levels, however, currently, level 2 only adds one additional check (4.2.8) for worker nodes. The Bottlerocket reporting API cannot automatically evaluate this additional check and therefore the two levels are functionally identical for automatic evaluation purposes.
{{% /alert %}}

## Examples

Expanding upon the general instructions to [run a report](../#running-a-report), for the Bottlerocket CIS benchmark use the identifier `cis-k8s`:

```shell
apiclient report cis-k8s
```

Adding the flag `-l` with the value of `2` will evaluate to the Level 2 benchmark. For example:

```shell
# Returns evaluation of CIS Benchmark Level 2
apiclient report cis-k8s -l 2
```

## Audit and Remediation

Refer to the [Kubernetes CIS Benchmark](https://www.cisecurity.org/benchmark/kubernetes) for detailed audit and remediation steps.

{{< on-github >}}
