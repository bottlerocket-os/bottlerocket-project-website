+++
question = "How do I disable Secure Boot?"
group = "Security"
+++

If you have a specific reason to disable Secure Boot in Bottlerocket, you will need to make infrastructure-level changes which vary by platform.

* `aws-*` variants: [Re-register the AMI](https://docs.aws.amazon.com/cli/latest/reference/ec2/register-image.html) without UEFI metadata.
* `vmware-*` variants: configure the virtual machine to disable Secure Boot.
