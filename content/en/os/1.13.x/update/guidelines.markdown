# Guidelines for Updating In-Place

## Introduction

There are some guidelines and considerations to keep in mind when updating your Bottlerocket nodes _in-place_.
Some update paths are valid, some are invalid, and there are some caveats you may need to consider based on the history of the project.

## Valid Update Paths

The update paths in this section are valid.

### Between Released Versions of the Same Variant

It is possible to update from one released version of a variant to another released version of the same variant.
Furthermore, skipping a version of the same variant is allowed.
Bottlerocket runs the necessary migrations in sequence if a version is skipped.
For example, updating from `aws-k8s-1.23` version `1.10.1` to `aws-k8s-1.23` version `1.11.0` is a valid update path.
Another valid update path is `aws-k8s-1.23` version `1.10.1` to `aws-k8s-1.23` version `1.12.0`.

## Invalid Update Paths

The update paths in this section are invalid.

### Across Different Variants

It is not possible to update from one variant to another.
For example, updating from an `aws-k8s-1.22` variant to an `aws-k8s-1.23` variant is an invalid update path.

## Caveats

You may need to consider the following caveats when updating your Bottlerocket nodes.

### Too Many Releases Between Versions

There is a known issue where Bottlerocket boots into a "no space left on device" error when updating between versions that are "too far apart" (too many intermediate versions between initial and target versions).
For example, updating between versions `1.7.2` and `1.11.0` fails in this way.

The workaround so far is to update Bottlerocket only a couple versions at a time from your initial version, using version locking, until you reach the desired version.

This caveat is discussed in detail in [issue 2589](https://github.com/bottlerocket-os/bottlerocket/issues/2589).
