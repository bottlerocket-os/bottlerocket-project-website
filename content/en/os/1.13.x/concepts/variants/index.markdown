+++
title="Variants"
type="docs"
description="Variants are the basis for environment-specific, ready-to-run images."
+++

General purpose distributions of Linux have "packages" that are delivered by a package manager.
This allows the distribution to ship a limited set of drivers, tools, and applications with the kernel; the user then adds additional packages that suits the workload after the operating system is installed.

Bottlerocket is not a general purpose Linux distribution and intentionally doesn’t have a package manager. Instead Bottlerocket has *variants*.
Variants are pre-defined sets of drivers, tools, and applications that are tailored to a specific architecture, platform, and orchestrator (as well as a “flavor,” more on that later).
For example, there is a variant that consists of everything needed to run as a Kubernetes (orchestrator) node on an aarch64 (architecture) processor in AWS EC2 (platform).
Bottlerocket delivers the variant as a complete, ready-to-run image.

Variants may be specific to particular versions of the orchestrator. 
For example, the variant for Kubernetes 1.25 is distinct from the variant for Kubernetes 1.24.

## Variants and images

Variants are a construct to identify the constituent components that are used to build an image.
As a consequence, you do not directly install a variant on a machine or instance, you install an image that is a build of the components contained in the variant at a specific Bottlerocket version.

## Variants and versions

The version of Bottlerocket is independent of the variant: a variant will be available across many different Bottlerocket versions.
Keep in mind that Kubernetes variants are only compatible with specific versions of Kubernetes: the Kubernetes version number is distinct from the version of Bottlerocket.

## Artifact file names

The file name for any Bottlerocket image artifact begins with `bottlerocket` and is followed by a [kebab case](https://www.alexhyett.com/snake-case-vs-camel-case-vs-pascal-case-vs-kebab-case/#kebab-case-kebab-case) delimited list of components.
The components in the file name follow a specific order:

```text
[platform]-[orchestrator]-[orchestrator version](optional:-[ flavour])-[Architecture]-[version]-[commit]
```

Example: `bottlerocket-aws-k8s-1.25-nvidia-aarch64-1.13.0...`

|Platform|Orchestrator|Orchestrator Version|Flavor|Architecture|Bottlerocket version|
|---|---|---|---|---|---|
|`aws`|`k8s`|`1.25`|`nvidia`|`aarch64`|`1.13.0`|

Example: `bottlerocket-vmware-k8s-1.24-x86_64-1.12...`

|Platform|Orchestrator|Orchestrator Version|Flavor|Architecture|Bottlerocket version|
|---|---|---|---|---|---|
|`vmware`|`k8s`|`1.24`|*none*|`x86_64`|`1.12.0`|

When referencing variants in writing, `bottlerocket-` and the commit are typically omitted for brevity.

## Flavors

Variants may also package in drivers for specific hardware called a “flavor.” Currently, the only flavor is 'nvidia', which adds support for Nvidia GPUs.

## Variants, updating, & migrating

You can update to a newer Bottlerocket version of the same variant (an ‘in-place update’).
However, you cannot update to a different variant: that is a migration (which involves replacing a node in the orchestrated cluster).

A few examples:

|Original|New|In-Place Update|Node Replacement / Migration|Explaination|
|---|---|---|---|---|
|aws-k8s-1.24-x86_64-**1.12.0**|aws-k8s-1.24-x86_64-**1.13.0**|✓|✓|This is moving between versions of the same variant, so this can be accomplished by an update|
|aws-k8s-**1.24**-x86_64-1.12.0|aws-k8s-**1.25**-x86_64-1.12.0|✗|✓|The orchestrator version is part of the variant, so this is a migration.|
|aws-k8s-**1.24**-x86_64-**1.12.0**|aws-k8s-**1.25**-x86_64-**1.13.0**|✗|✓|Both the Bottlerocket version and the variant are changing so this must be accomplished by a migration.|
|aws-k8s-1.24-x86_64-1.13.0|aws-k8s-1.24-**nvidia**-x86_64-1.13.0|✗|✓|The flavor is part of the variant, so this change must be accomplished by a migration|
|aws-**ecs-1**-x86_64-1.13.0|aws-**k8s-1.25**-x86_64-1.13.0|✗|✗|The orchestrator has changed. The cluster must be rebuilt.|

If you are using a node replacement strategy, the distinction between migrating and updating is less important as any change is effectively a migration.
