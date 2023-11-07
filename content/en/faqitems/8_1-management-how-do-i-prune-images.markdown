+++
question = "How do I purge or prune old conatiner images from Bottlerocket?"
group = "Mangagement"
+++

You should not need to manually clean up container images from Bottlerocket.

On Kubernetes variants, `kubelet` manages the container image clean up, the settings `{{< ver-ref project="os" page="/api/settings/kubernetes" hash="#image-gc-high-threshold-percent" >}}settings.kubernetes.image-gc-high-threshold-percent{{</ ver-ref>}}` and `{{< ver-ref project="os" page="/api/settings/kubernetes" hash="#image-gc-low-threshold-percent" >}}settings.kubernetes.image-gc-low-threshold-percent{{</ ver-ref>}}` allow you when this clean up occurs.


On ECS variants, the ECS Agent manages the container image clean up, the settings `{{< ver-ref project="os" page="/api/settings/ecs/" hash="#image-cleanup-enabled" >}}image-cleanup-enabled{{</ ver-ref>}}`, `{{< ver-ref project="os" page="/api/settings/ecs/" hash="#image-cleanup-age" >}}image-cleanup-age{{</ ver-ref>}}`, `{{< ver-ref project="os" page="/api/settings/ecs/" hash="#image-cleanup-delete-per-cycle" >}}image-cleanup-delete-per-cycle{{</ ver-ref>}}`, and
`{{< ver-ref project="os" page="/api/settings/ecs/" hash="#image-cleanup-wait" >}}image-cleanup-wait{{</ ver-ref>}}`.



