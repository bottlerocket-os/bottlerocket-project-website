+++
title="Guidelines for Updating In-Place"
type="docs"
description="Moving to newer versions without replacing nodes"
+++

## Introduction

There are some guidelines and considerations to keep in mind when updating your Bottlerocket nodes _in-place_.
Some movements between versions are updates, some are not updates, and there are some caveats you may need to consider based on the history of the project.

## Update Paths

Certain movements between releases of Bottlerocket are accessible through an _in-place_ update path.

### Between Minor or Patch Versions of the Same Variant

With the exception of moving between major versions and a [caveat discussed below](#too-many-releases-between-versions), it is possible to update _in-place_ from one released version of a variant to another released version of the same variant.
In particular, the following update paths work:

- Minor version to minor version (e.g. `1.10.0` to `1.11.0`)
- Patch version to patch version (e.g. `1.9.1` to `1.9.2`)
- Minor version to patch version (e.g. `1.10.0` to `1.10.1`)
- Patch version to minor version (e.g. `1.10.1` to `1.11.0`)

Furthermore, skipping minor or patch versions of the same variant is allowed.
Bottlerocket runs all update [settings migrations](https://github.com/bottlerocket-os/bottlerocket/tree/develop/sources/api/migration#data-store-migration) between the initial and target versions in sequence if a version is skipped.
So, for the `1.10.1` to `1.12.0` example, the [settings migrations](https://github.com/bottlerocket-os/bottlerocket/tree/develop/sources/api/migration#data-store-migration) from `1.11.0` and `1.11.1` are run as part of the update to `1.12.0`.

## Caveats and Limits

You may need to consider the following caveats when updating your Bottlerocket nodes.

### Too Many Releases Between Versions

There is a [known issue](https://github.com/bottlerocket-os/bottlerocket/issues/2589) where Bottlerocket boots into a "no space left on device" error when updating between versions that are "too far apart" (too many intermediate releases -- minor or patch -- between the initial and target).
For example, updating between versions `1.7.2` and `1.11.0` fails in this way.

The workaround is to update Bottlerocket only a couple releases at a time from your starting point, using version locking, until you reach the desired state.

This caveat is discussed in detail in [issue 2589](https://github.com/bottlerocket-os/bottlerocket/issues/2589).

Specifically, there is [an important note regarding updating to the latest versions of Bottlerocket](https://github.com/bottlerocket-os/bottlerocket/issues/2589#issuecomment-1344941291).

### Updates vs. Other Movements

There are some movements between releases of Bottlerocket that are not accessible through an update path.
Such movements are described below.

#### Between Major Versions

It is not possible to update _in-place_ from one major version to another.
Major versions are considered breaking changes.

In order to move between major versions, node replacement with the desired release is necessary.

#### Across Different Variants

It is not possible to update _in-place_ from one variant to another.
For example, moving from an `aws-k8s-1.22` variant to an `aws-k8s-1.23` variant is not an update path.

In order to move between Kubernetes versions (or any variant), you must replace the nodes in your cluster with new nodes running the desired variant.

{{< on-github >}}
