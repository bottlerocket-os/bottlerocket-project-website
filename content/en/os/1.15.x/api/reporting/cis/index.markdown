+++
title = "Bottlerocket CIS Benchmark"
type = "docs"
description = "Generating a Bottlerocket CIS Benchmark report"
toc_hide=true
+++

The [Bottlerocket CIS Benchmark](https://www.cisecurity.org/benchmark/bottlerocket) contains a number of security best practices to harden Bottlerocket worker nodes.
The benchmark contains two levels:

* **Level 1:** basic guidelines with clear security benefits that do not inhibit the node.
Bottlerocket’s default settings are compliant with level 1.
* **Level 2:** detailed, specific guidance that provide more defence to the node.
This level introduces some trade-offs between functionality and security.

The report API has built-in tests that allow you to evaluate the state of the node to both Level 1 and Level 2.

## Examples

Expanding upon the general instructions to [run a report](../#running-a-report), for the Bottlerocket CIS benchmark use the identifier `cis`:

```shell
apiclient report cis
```

Adding the flag `-l` with the value of `2` will evaluate to the Level 2 benchmark. For example:

```shell
# Returns evaluation of CIS Benchmark Level 2
apiclient report cis -l 2
```

## Audit and Remediation

Refer to the [Bottlerocket CIS Benchmark](https://www.cisecurity.org/benchmark/bottlerocket) for detailed audit and remediation steps.
