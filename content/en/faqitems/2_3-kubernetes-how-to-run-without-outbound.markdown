+++
question = "What outbound endpoints need to be permitted to run Bottlerocket on EKS?"
group = "Kubernetes"
+++

You may wish to limit outbound access for your EKS nodes.
Bottlerocket needs ECR (even if you use another registry, we have images on ECR), EKS, IMDS, SSM, and possibly STS endpoints.

See [Bottlerocket Without Internet Access](https://github.com/bottlerocket-os/bottlerocket/discussions/3953).
