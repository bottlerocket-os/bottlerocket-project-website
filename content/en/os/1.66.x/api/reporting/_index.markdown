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

## FIPS 140-3 for Bottlerocket

Bottlerocket supports running workloads through the Bottlerocket FIPS [variants].
These variants constrain the kernel and userspace components to the use of cryptographic modules that have been submitted to the FIPS 140-3 [Cryptographic Module Validation Program] \(CMVP\).

This includes the [Amazon Linux 2023 Kernel Cryptographic API] and the [AWS-LC Cryptographic Module].
In FIPS variants, modules are configured based on their respective security policies.
You can generate a [Bottlerocket FIPS report] to verify the configuration.

Per the [FedRAMP Policy for Cryptographic Module Selection and Use], Bottlerocket ships the **_updated streams_** for these modules, with the latest patches and updates applied to the software, regardless of the FIPS-validation status of the changed software.

[variants]: ../../concepts/variants
[Cryptographic Module Validation Program]: https://csrc.nist.gov/projects/cryptographic-module-validation-program/fips-140-3-standards
[Amazon Linux 2023 Kernel Cryptographic API]: https://csrc.nist.gov/projects/cryptographic-module-validation-program/certificate/4808
[AWS-LC Cryptographic Module]: https://csrc.nist.gov/projects/cryptographic-module-validation-program/certificate/4631
[Bottlerocket FIPS report]: ./fips
[FedRAMP Policy for Cryptographic Module Selection and Use]: https://www.fedramp.gov/rev5/fips/

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

{{< on-github >}}
