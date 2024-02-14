+++
question = "Why are my nodes egressing to `updates.bottlerocket.aws`?"
group = "Updates"
+++

The [Bottlerocket Updater API](https://github.com/bottlerocket-os/bottlerocket/blob/develop/sources/updater/README.md) uses TUF metadata served from a public endpoint.
The default AWS variants endpoint is `updates.bottlerocket.aws`.
