+++
question = "What's the difference between Firecracker and Bottlerocket?"
group = "Project"
+++

Quite a lot!
[Firecracker](https://firecracker-microvm.github.io/) is a *virtualization* technology and Bottlerocket is an *operating system*. From the [Firecracker FAQ](https://firecracker-microvm.github.io/#faq):

> Firecracker is an alternative to QEMU that is purpose-built for running serverless functions and containers safely and efficiently, and nothing more.

Bottlerocket does not uses Firecracker.
Bottlerocket and Firecracker actually have very little in common except they:

* are open source projects started at AWS,
* use the Rust programming language,
* have names related to fireworks.
