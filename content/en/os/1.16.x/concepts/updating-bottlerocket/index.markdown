+++
title = "Updates"
type = "docs"
description = "Overview of different methods to update Bottlerocket"
+++

Bottlerocket is designed to be updated in an [image-based fashion](https://github.com/bottlerocket-os/bottlerocket#updates).
This means that updates are applied by downloading an image of the entire operating system to a different partition on disk, then switching to using that partition when the system is rebooted.
This is done instead of a series of individual package updates on the current operating system partition.
This is a departure from the traditional package-based Linux update model such as `apt` or `yum`, which are what you would find in Ubuntu or Amazon Linux.

## Ways To Update

The update method you choose depends on the [Bottlerocket variant](https://github.com/bottlerocket-os/bottlerocket#variants) you are using and your environment.

The ways to update Bottlerocket can be classified into two main categories: _in-place updates_ and _node replacement_.
_In-place updates_ are updates that are applied to the same node (no infrastructure reprovisioning), while _node replacement_ is when you replace an existing node with a new node that is running the updated version of Bottlerocket.

At its core, an _in-place update_ is a call to the Bottlerocket API server using `apiclient`.
The `apiclient` command can be run from the [control container](https://github.com/bottlerocket-os/bottlerocket#control-container).
There are also orchestrated systems that perform the `apiclient` calls for you: the [ECS updater](../../update/methods/in-place/#ecs) for ECS, [Brupop](../../update/methods/in-place/#brupop) for Kubernetes, and [SSM Command Documents](../../update/methods/in-place/#ssm) for both.

The following table shows whether a given update method is an _in-place update_ or a _node replacement_.

In-Place Updates | Node Replacement
--- | ---
[`apiclient` commands](../../update/methods/in-place/#apiclient-commands) | [EKS Console](../../update/methods/node-replacement/#eks-console)
[ECS updater](../../update/methods/in-place/#ecs) | [`eksctl`](../../update/methods/node-replacement/#eksctl)
[Brupop](../../update/methods/in-place/#brupop) |
[SSM command documents](../../update/methods/in-place/#ssm) |

## Conclusion

There are many ways to update Bottlerocket, including:

- Running [`apiclient` commands](../../update/methods/in-place/#apiclient-commands) directly in the [control container](https://github.com/bottlerocket-os/bottlerocket#control-container)
- The [ECS updater](../../update/methods/in-place/#ecs)
- [Brupop](../../update/methods/in-place/#brupop), the [EKS Console](../../update/methods/node-replacement/#eks-console), and [`eksctl`](../../update/methods/node-replacement/#eksctl) on Kubernetes
- [Applying SSM Command Documents](../../update/methods/in-place/#ssm) to your nodes

It is also possible to [lock your nodes to a specific release](../../update/locking-to-a-specific-release).

{{< on-github >}}
