+++
question = "How do I access logs for bootstrap containers?"
group = "Troubleshooting"
+++

Bootstrap container output should be present in the system journal.
You can access the system journal {{< ver-ref project="os" page="/install/quickstart/aws/host-containers/index.markdown#exploring-the-admin-container" >}}from the admin container{{< /ver-ref >}} as follows:

```bash
sudo chroot /.bottlerocket/rootfs journalctl
```
