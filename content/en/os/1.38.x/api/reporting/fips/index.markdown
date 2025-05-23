+++
title = "Bottlerocket FIPS report"
type = "docs"
description = "Generating a Bottlerocket FIPS report"
toc_hide=true
+++

The FIPS report includes information about the state of the FIPS support in the host.
The report API has built-in tests that allow you to evaluate the state of the node.

> Note: this report is only available on FIPS variants

## Examples

```shell
apiclient report fips

Benchmark name:  FIPS Security Policy
Version:         v1.0.0
Reference:       https://csrc.nist.gov/
Benchmark level: 1
Start time:      <>

[PASS] 1.0       FIPS mode is enabled. (Automatic)
[PASS] 1.1       FIPS module is Amazon Linux 2023 Kernel Cryptographic API. (Automatic)
[PASS] 1.2       FIPS self-tests passed. (Automatic)

Passed:          3
Failed:          0
Skipped:         0
Total checks:    3
```
