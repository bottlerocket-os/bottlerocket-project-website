+++
question = "Why do some of the nodes in my cluster have an update available and others do not?"
group = "Updates"
+++
This is normal.
Bottlerocket uses "waves" to stagger deployment of updates.
When a node starts for the first time, the boot process generates a random seed (or uses the value from {{< setting-reference setting="settings.updates.seed" current_version="true">}}settings.updates.seed{{</ setting-reference >}}).
Bottlerocket's update process uses the seed to determine if a node should update, so in the situation where some of your nodes have an available update and some do not, it just means that the update wave hasn't reached that seed of some nodes and it has for the others.
