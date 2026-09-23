+++
title="pki"
type="docs"
toc_hide=true
description="Settings related to Custom CA Certificates (`settings.pki.*`)"

+++

By default, Bottlerocket ships with the [Mozilla CA certificate store](https://wiki.mozilla.org/CA/Included_Certificates), but you can add self-signed certificates with `settings.pki.<bundle name>`.

{{% alert title="Tip" color="success" %}}
If your user data is over the size limit for the platform, you can use `apiclient` with this setting from within a [bootstrap container](https://github.com/bottlerocket-os/bottlerocket#bootstrap-containers-settings) to add certificates.
{{% /alert %}}

{{< settings >}}
