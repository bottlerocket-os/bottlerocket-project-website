+++
title = 'Security'
type = 'import'
source = 'bottlerocket'
markdown_file = 'SECURITY.md'
+++
## Security advisories

Bottlerocket publishes its security advisories in an `updateinfo.xml` file at [advisories.bottlerocket.aws](https://advisories.bottlerocket.aws/updateinfo.xml.gz).
This file is the canonical source of Bottlerocket security advisories: use it for programmatic access.
For example, to download it with `curl`:

```sh
curl -L https://advisories.bottlerocket.aws/updateinfo.xml.gz -o updateinfo.xml.gz
```

Each advisory names the affected packages and the version that addresses it.
To find out whether an advisory applies to a Bottlerocket host, compare `updateinfo.xml` with the host's [Software Bill of Materials (SBOM)](https://github.com/bottlerocket-os/bottlerocket#sbom).
Every Bottlerocket image since v1.53.0 ships an SBOM that inventories the packages built into the OS, in two formats: `/usr/share/bottlerocket/spdx-sbom.json` ([SPDX](https://spdx.dev/)) and `/usr/share/bottlerocket/cyclonedx-sbom.json` ([CycloneDX](https://cyclonedx.org/)).
Its RPM packages have the same names, architectures and versions as the packages in `updateinfo.xml`: an advisory applies if the installed version of one of its packages is older than the version it names.

Since July 2024, Bottlerocket no longer publishes new GitHub Security Advisories (GHSAs) in the [bottlerocket-os/bottlerocket](https://github.com/bottlerocket-os/bottlerocket/security/advisories) repository.
See [Changes to Bottlerocket's security advisory publication](https://github.com/bottlerocket-os/bottlerocket/discussions/4063) for additional details.
