+++
question = "How do I perform fault injection with Bottlerocket?"
group = "EKS"
+++

Fault injection is possible with Bottlerocket on EKS through using fault injection tools such as those in [Istio](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/) or [Chaos Mesh](https://chaos-mesh.org/docs/simulate-pod-chaos-on-kubernetes/).
Additionally, [AWS Fault Injection Simulator](https://aws.amazon.com/fis/faqs/) (FIS) is an option for fault injection with Bottlerocket on EKS.
In order to use AWS FIS, you need SSM access to the node, which is available through the [control container](https://github.com/bottlerocket-os/bottlerocket#control-container).
