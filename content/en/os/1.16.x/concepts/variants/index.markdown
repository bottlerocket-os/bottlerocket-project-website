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
|aws-**ecs-2**-x86_64-1.15.0|aws-**k8s-1.28**-x86_64-1.15.0|✗|✗|The orchestrator has changed. The cluster must be rebuilt.|

If you are using a node replacement strategy, the distinction between migrating and updating is less important as any change is effectively a migration.

## Software inventory and security advisories

Since Bottlerocket doesn’t use a package manager, keeping track of the software delivered as part of a variant is a little different.
Additionally, the concept of a ‘package’ is only relevant as a part of the build process.
In the course of running Bottlerocket, you probably want to keep track of what specific software and versions you are using as well as understand how this software relates to known vulnerabilities.

{{% alert title="Note" color="success" %}}
The best patching strategy for Bottlerocket is to always update to the most recent release.
Since packages are only used at build-time and the packages cannot mutate, the inventory will never change for a given version and variant.
Updating to the most recent version will patch all packages.
{{% /alert %}}

Bottlerocket provides information to both understand the software included in a variant and how it connects to published security advisories.

### Software Inventory

The Bottlerocket build process generates an `applications.json` file at `/var/lib/bottlerocket/inventory/` on the host file system. This JSON file contains objects that represent a build-time package. The `applications.json` file structure is as follows:

```json
{
  "Content": [
    {
      "Name": <name string>,
      "Publisher": "Bottlerocket",
      "Version": <version as string>,
      "Release": <build ID as string>,
      "InstalledTime": <ISO 8601 date as string>,
      "ApplicationType": "Unspecified",
      "Architecture": <architecture as string>,
      "Url": <url as string>,
      "Summary": <description as string
    },
    ...
  ]
}
```

`Publisher` and `ApplicationType` are “Bottlerocket” and “Unspecified” (respectively) for all packages across all variants.
`Version`, `Release`, `InstalledTime`, and `Architecture` are a consistent value for each object in the `Content` array in a given release as they represent data about the build and variant of Bottlerocket, not individual packages.

### Security Advisories

Bottlerocket publishes security advisories on [the repo’s GitHub’s Security tab](https://github.com/bottlerocket-os/bottlerocket/security/advisories) and a gzipped `updateinfo.xml` file at advisories.bottlerocket.aws (make sure you follow redirects: e.g. use `curl -LO https://advisories.bottlerocket.aws/updateinfo.xml.gz`).  

Both places contain approximately the same information but in different formats.
The security advisories match with the package information provided in the `applications.json` file.
For example, take the following snippet from `applications.json`:

```json
{
  "Content": [
    ...
    {
        "Name": "kernel-6.1",
        "Publisher": "Bottlerocket",
        "Version": "1.16.1",
        "Release": "763f6d4c",
        "InstalledTime": "2023-11-09T08:15:34Z",
        "ApplicationType": "Unspecified",
        "Architecture": "x86_64",
        "Url": "https://www.kernel.org/",
        "Summary": "The Linux kernel"
    }
    ...
  ]
}

```

And a snippet from the `updateinfo.xml` file (which relates to [GHSA-868r-x68r-5c5p on GitHub](https://github.com/bottlerocket-os/bottlerocket/security/advisories/GHSA-868r-x68r-5c5p), note the representation of the similar information).

```xml
<updates>
    ...
    <update author="etungsten" from="etungsten" status="final" type="security" version="1.4">
        <id>GHSA-868r-x68r-5c5p</id>
        <title>kernel CVE-2023-5345</title>
        <issued date="2023-11-13T22:21:51Z"/>
        <updated date="2023-11-13T22:21:51Z"/>
        <severity>medium</severity>
        <description>A flaw was found in the SMB client component in the Linux kernel. In case of an error in smb3_fs_context_parse_param, ctx-&gt;password was freed, but the field was not set to NULL, potentially leading to a use-after-free vulnerability. This flaw allows a local user to crash or potentially escalate their privileges on the system.</description>
        <references>
            <reference href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-5345" id="CVE-2023-5345" type="cve"/>
            <reference href="https://github.com/bottlerocket-os/bottlerocket/security/advisories/GHSA-868r-x68r-5c5p" id="GHSA-868r-x68r-5c5p" type="ghsa"/>
        </references>
        <pkglist>
            <collection short="bottlerocket">
                <name>Bottlerocket</name>
                <package arch="x86_64" name="kernel-6.1" version="1.16.1" release="0" epoch="0"/>
                <package arch="aarch64" name="kernel-6.1" version="1.16.1" release="0" epoch="0"/>
            </collection>
        </pkglist>
    </update>
    ...
</updates>
```

If you are building a script to determine if your Bottlerocket nodes need patching, evaluate the `.Content.Name`, `.Content.Version`, and `.Content.Architecture` from the object in `applications.json` and compare these values with the `./updates/update/pkglist/collection/package[@name]`, `./updates/update/pkglist/collection/package[@version]`, and `./updates/update/pkglist/collection/package[@arch]` in `updateinfo.xml`.

Human beings should use the GitHub security advisories compared to the {{< ver-ref project="os" page="/version-information/packages-by-variant" >}} Packages by Variant list{{</ ver-ref >}} (or use other tools).

{{< on-github >}}
