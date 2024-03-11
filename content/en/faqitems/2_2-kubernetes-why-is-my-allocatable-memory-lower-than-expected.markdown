+++
question = "Why is my allocatable memory lower than expected?"
group = "Kubernetes"
+++

You may observe that allocatable memory is lower than on general-purpose Linux distributions. There are 2 possible reasons for this:

* As the [control container](https://github.com/bottlerocket-os/bottlerocket-control-container) runs in a second instance of containerd, a small amount of memory is reserved for this process. Typically this is just a few MiB.

* If you increase the [maxPods setting on the kubelet](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1/#kubelet-config-k8s-io-v1beta1-KubeletConfiguration), you may see a linear decrease in allocatable memory proportional to the max number of pods. The formula for this reservation is detailed in the [Settings Reference](https://bottlerocket.dev/en/os/1.19.x/api/settings/kubernetes/#kube-reserved). This may be different to the calculation used by other Linux distributions. This setting can be overridden by providing a static value to the settings [user data](https://github.com/bottlerocket-os/bottlerocket#using-user-data).

