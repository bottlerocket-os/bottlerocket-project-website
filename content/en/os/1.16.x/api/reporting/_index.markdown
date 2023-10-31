+++
title = "Reporting"
type = "docs"
description = "Using the Report API to automate operating system-level reporting."
+++

Operating systems are complicated; inspecting and reporting data about the OS is a common but tedious task that needs repeating as configurations change.
Manually gathering this data for Bottlerocket has additional complications due to API abstracted settings and indirect access to the host.

The Bottlerocket report API provides a mechanism to automate operating system-level reporting.
You can run reports that self-evaluate the OS based on the current state of the system compared to known standards.

## Center for Internet Security (CIS) Benchmark

You can currently generate reports on your Bottlerocket nodes against two different CIS benchmarks:

- [Bottlerocket CIS Benchmark](./cis/)
- [Kubernetes CIS Benchmark](./cis-k8s)

## Running a report

You will need to be running the [control container](../../concepts/shell-less-host/#control-container) or, alternately, mount the `apiclient` binary and the Bottlerocket API unix socket into a container as well as have the appropriate SELinux permissions.

First, create an interactive shell session on the control container or container with `apiclient`.
From the shell run:

```shell
apiclient report <report identifier>
```

This will evaluate the current node to a particular report and return the results in a human-readable format.

If you intend to process the report with some other piece of software,  add the flag `-f` with the value of `json`  for a JSON representation of the report:

```shell
# Returns evaluation of the report in JSON format
apiclient report <report identifier> -f json
```

## Evaluation Results

Evaluation of each item on the report will result in one of three outcomes:

* `PASS`: Evaluated item is in compliance with the benchmark.
* `FAIL`: Evaluated item is not in compliance with the benchmark.
* `SKIP`: The item could not be automatically evaluated.

## All Available Reports
