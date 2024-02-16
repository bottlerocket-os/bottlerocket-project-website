+++
type="docs"
title="Documentation"
+++

{{< current-full-version >}}

You may be familiar with general purpose Linux distributions like Ubuntu, Fedora, or Amazon Linux.
With these Linux distributions, you can run a variety of workloads, setup in a variety of ways.
While Bottlerocket is also a Linux distribution, Bottlerocket stands in stark contrast to general purpose distributions by being specifically optimized to host containers and interoperate directly with container orchestrators such as Kubernetes or ECS.
Additionally, when compared to general purpose operating systems, Bottlerocket has several operational differences which minimize the security footprint, lower maintenance burden, and enforce container best practices.

## Getting to know Bottlerocket

This documentation provides context to understand the operating system at a high-level, practical how-to guides, and reference material.

The {{< ver-ref project="os" page="/concepts" >}}Concepts section{{< /ver-ref >}} is a good starting point if you’re entirely unfamiliar with Bottlerocket. 
This section, like the rest of the documentation, is non-linear.
However, the most fundamental building blocks needed to understand Bottlerocket can be found on the {{< ver-ref project="os" page="/concepts/components" >}}Components{{< /ver-ref >}} and {{< ver-ref project="os" page="/concepts/variants" >}}Variants{{< /ver-ref >}} pages.

## Organization

This documentation is divided by project and largely mirrors the repository boundaries of the Bottlerocket GitHub organization.

| GitHub Repo | Section | Description |
|-------------|---------------|-------------|
| [`bottlerocket-os/bottlerocket`](https://github.com/bottlerocket-os/bottlerocket) | [OS](./os/)  | Primary documentation for the operating system. |
| [`bottlerocket-os/bottlerocket-update-operator`](https://github.com/bottlerocket-os/bottlerocket-update-operator) | [Brupop](./brupop/)  | Documentation for the Kubernetes operator that automates Bottlerocket updates  |

Inside each section, the documentation is further scoped to minor versions of each project with the most recent release being marked as (*Current*).

Where available, **Version Information** sections contain reference metadata about the documented release.

## Navigation

The left hand navigation tree provides a quick way to switch between pages and sections.
The URLs in this documentation intend to be human readable and match the navigation as closely as possible.

The right hand column of most pages contains a table of contents you can use to jump between sections on the same page.
These links alter the URL’s hash fragment and are useful when sharing a link to a specific part of a page with others.

## Improvements, questions, and contributions

This site, like Bottlerocket, is [open source and developed in-the-open on GitHub](https://github.com/bottlerocket-os/project-website).
If you find inaccuracies, gaps, or bugs in the documentation, [feel free to open an issue](https://github.com/bottlerocket-os/project-website/issues).
If you know how to solve the problem yourself (and you want to make the maintainers very happy), go ahead and [make a pull request](https://github.com/bottlerocket-os/project-website/pulls).

{{< nav-bar-open html_id="m-enos-check" >}}
