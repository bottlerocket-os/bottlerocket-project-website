+++
question = "How do I SSH into Bottlerocket?"
group = "Access"
+++

Bottlerocket's {{< ver-ref project="os" page="/install/quickstart/aws/host-containers/index.markdown" >}}control container{{< /ver-ref >}} includes the capability for accessing the host through SSM.
SSM is the preferred way to access a Bottlerocket node.

If SSM does not work in your use case, there is a way to [access the host through SSH by using the admin container](https://github.com/bottlerocket-os/bottlerocket-admin-container#authenticating-with-the-admin-container).
