+++
question = "How do I perform fault injection with Bottlerocket?"
group = "Kubernetes"
+++

Fault injection testing on a Bottlerocket cluster is not different from testing on a cluster running another operating system.
You can use fault injection tools such as those in [Istio](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/) or [Chaos Mesh](https://chaos-mesh.org/docs/simulate-pod-chaos-on-kubernetes/).

Alternatively, if you are using EKS, you can use [AWS Fault Injection Simulator](https://aws.amazon.com/fis/faqs/) (FIS).
In order to use AWS FIS, you need SSM access to the node, which is available through the [control container](https://github.com/bottlerocket-os/bottlerocket#control-container).
