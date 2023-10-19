+++
question = "How do I manage an on-prem Bottlerocket node similar to how I manage a cloud Bottlerocket node?"
group = "On-Prem"
+++

If you are using the [control container](https://github.com/bottlerocket-os/bottlerocket#control-container), you can use SSM to manage on-prem Bottlerocket nodes by [passing in your own activation information for SSM](https://github.com/bottlerocket-os/bottlerocket-control-container#connecting-to-aws-systems-manager-ssm).

Otherwise, you are in control of what [host containers](https://github.com/bottlerocket-os/bottlerocket#custom-host-containers) you have running and accessible.
Host containers have the `apiclient` binary available.
This allows you to use custom host containers to manage a Bottlerocket node in a similar fashion to the control container.
