+++
type="docs"
title="Brupop"
description="Documentation for the Bottlerocket Update Operator (Brupop)"
body_class="suppress_section_listing"
no_version_warning=true
+++


This section covers installing and using the Bottlerocket Update Operator only.
If you’re seeking general information about Bottlerocket updates, {{< cross-project-current-link project="os" url="/en/os/x.x.x/update/" >}}check the Updating documentation for the OS{{< /cross-project-current-link >}}.

If you’re looking for information on building, contributing to, or learning about the inner workings of Brupop, the [GitHub repo](https://github.com/bottlerocket-os/bottlerocket-update-operator) is a better destination.

## Organization

The Brupop documentation is organized by minor version, with each minor release getting it’s own namespaced, version-specific section.
Inside each version-specific sections are subsections which address specific tasks or categories of information.

The current documented versions:

{{< subsections-list >}}

## Version & Update Policy

Brupop follows semantic ([semver](https://semver.org/)) versioning to ensure that minor (e.g. `1.1.1` -> `1.2.0`) or patch (e.g. `1.1.0` -> `1.1.1`) updates do not introduce any breaking or incompatible changes.
However, patches are only provided to the latest version, so you should keep your Brupop installation up to date with the latest release.

## Something Missing?

This [documentation is open-source](https://github.com/bottlerocket-os/bottlerocket-project-website/tree/main/content/en/brupop) and likely incomplete, but will evolve over time to encompass a more complete explanation of the software.
Should you find gaps, you’re invited to file issues or contribute.
