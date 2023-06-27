
## Safe Updates

Bottlerocket is designed to be updatable but it **doesn’t have a package manager.**
It doesn’t need one.
Updates are delivered via an image that is downloaded to a specific partition.
When you’re ready to update, let your orchestrator drain the node and then tell Bottlerocket to apply the update and reboot when ready.
Bottlerocket will swap the partitions and boot with the new version atomically.

{{< stackedfigure caption="Bottlerocket uses multiple partitions to manage updates. Changeover occurs atomically at reboot." >}}
    {{% readfile "includes/homepage/update.svg" %}}
{{</ stackedfigure>}}

Because system settings are accomplished through an API, Bottlerocket knows how to migrate these settings between versions.
Should something go awry during an update, the Bottlerocket update system lets you revert to the previously working version with your settings intact.

Bottlerocket updates can be managed manually or with the help of Bottlerocket’s orchestrator-specific tools: [Bottlerocket Update Operator (brupop)](https://github.com/bottlerocket-os/bottlerocket-update-operator) and the [ECS updater](https://github.com/bottlerocket-os/bottlerocket-ecs-updater).
