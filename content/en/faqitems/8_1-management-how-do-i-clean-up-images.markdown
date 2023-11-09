+++
question = "How do I clean up old container images from Bottlerocket?"
group = "Management"
+++

You should not need to manually clean up container images from Bottlerocket, this is handled automatically by the orchestrator agent.

On Kubernetes variants, `kubelet` manages the container image clean up, the settings `{{< ver-ref project="os" page="/api/settings/kubernetes" hash="#image-gc-high-threshold-percent" >}}settings.kubernetes.image-gc-high-threshold-percent{{</ ver-ref>}}` and `{{< ver-ref project="os" page="/api/settings/kubernetes" hash="#image-gc-low-threshold-percent" >}}settings.kubernetes.image-gc-low-threshold-percent{{</ ver-ref>}}` allow you to control how this clean up occurs.

On ECS variants, the [ECS Agent](https://github.com/aws/amazon-ecs-agent) manages the container image clean up, the settings `{{< ver-ref project="os" page="/api/settings/ecs/" hash="#image-cleanup-enabled" >}}settings.ecs.image-cleanup-enabled{{</ ver-ref>}}`, `{{< ver-ref project="os" page="/api/settings/ecs/" hash="#image-cleanup-age" >}}settings.ecs.image-cleanup-age{{</ ver-ref>}}`, `{{< ver-ref project="os" page="/api/settings/ecs/" hash="#image-cleanup-delete-per-cycle" >}}settings.ecs.image-cleanup-delete-per-cycle{{</ ver-ref>}}`, and
`{{< ver-ref project="os" page="/api/settings/ecs/" hash="#image-cleanup-wait" >}}settings.ecs.image-cleanup-wait{{</ ver-ref>}}` allow you to control how this clean up occurs.

If you want to manually clean up images, log into the {{< ver-ref project="os" page="/install/quickstart/aws/host-containers" hash="#interacting-with-a-bottlerocket-node-through-host-containers" >}}admin container{{</ ver-ref >}} and use `ctr`'s `image` commands with the address pointed at `/run/dockershim.sock`. For example, on Kubernetes variants to list all images:

```shell
sudo chroot /.bottlerocket/rootfs ctr -n k8s.io image ls
```

From here you can decide which images you want to manually remove.
