+++
title = "Reporting"
type = "docs"
description = "Using the Report API to automate operating system-level reporting."
+++

Operating systems are complicated; inspecting and reporting data about the OS is a common but tedious task that needs to be repeated as configurations change.
Manually gathering this data for Bottlerocket has additional complications due to API abstracted settings and indirect access to the host.

The Bottlerocket report API provides a mechanism to automate operating system-level reporting.
You can run reports that self-evaluate the OS based on the current state of the system compared to known standards.

## Center for Internet Security (CIS) Benchmark

The [Bottlerocket CIS Benchmark](https://www.cisecurity.org/benchmark/bottlerocket) contains a number of security best practices to harden Bottlerocket worker nodes.
The benchmark contains two levels:

* **Level 1:** basic guidelines with clear security benefits that do not inhibit the node.
Bottlerocket’s default settings are compliant with level 1.
* **Level 2:** detailed, specific guidance that provide more defence to the node.
This level introduces some trade-offs between functionality and security.

The report API has built-in tests that allow you to evaluate the state of the node to both Level 1 and Level 2.

### Evaluating a node to the CIS Benchmark

You will need to be running the [control container](../../concepts/shell-less-host/#control-container) or, alternately, mount the `apiclient` binary and the Bottlerocket API unix socket into a container as well as have the appropriate SELinux permissions.

First, create an interactive shell session on the control container or container with `apiclient`.
From the shell run:

```shell
apiclient report cis
```

This will evaluate the current node to the Level 1 benchmark and provide human readable output.

Adding the flag `-l` with the value of `2` will evaluate to the Level 2 benchmark. For example:

```shell
# Returns evaluation of CIS Benchmark Level 2
apiclient report cis -l 2
```

If you intend to process the report with some other piece of software,  add the flag `-f` with the value of `json`  for a JSON representation of the report:

```shell
# Returns evaluation of CIS Benchmark Level 2 in JSON format
apiclient report cis -l 2 -f json
```

#### Evaluation Results

Evaluation of each item on the benchmark will result in one of three outcomes:

* `PASS`: Evaluated item is in compliance with the benchmark.
* `FAIL`: Evaluated item is not in compliance with the benchmark.
* `SKIP`: The item could not be automatically evaluated.
