+++
title="dns"
type="docs"
toc_hide=true
description="Settings related to custom DNS settings (`settings.dns.*`)"
+++

Bottlerocket generates the host `resolv.conf`[^1] from `settings.dns.*` values.

{{< settings >}}

[^1]: `/etc/resolv.conf` for variants using [wicked](https://github.com/openSUSE/wicked) and `/run/systemd/resolve/resolv.conf` for variants using systemd-networkd (`*-k8s-1.28-*` and `*-ecs-2-*` and newer).
