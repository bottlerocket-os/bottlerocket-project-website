+++
title="boot"
type="docs"
toc_hide=true
description="Settings related to kernel boot config (`settings.boot.*`)"
+++

{{% alert title="Warning" color="warning" %}}
Bottlerocket only allows boot configuration for `kernel` and `init`.
If you specify any other boot config key the settings generation will fail.
{{% /alert %}}

{{< settings >}}
