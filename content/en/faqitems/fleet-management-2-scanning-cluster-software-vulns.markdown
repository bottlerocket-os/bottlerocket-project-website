+++
question = "How do I scan my cluster for software vulnerabilities?"
group = "Fleet Management"
+++

Host vulnerability scanning capability is included with Bottlerocket by using the {{< ver-ref project="os" page="/install/quickstart/aws/host-containers/index.markdown" >}}control container{{< /ver-ref >}} to utilize [Amazon Inspector](https://docs.aws.amazon.com/inspector/latest/user/scanning-ec2.html).
Amazon Inspector works via the SSM agent, which is included in the control container.
