+++
title = "Shell-less Host"
type = "docs"
description = "Using Linux without a shell" 
+++

Bottlerocket images do not have an SSH server nor even a shell.
As it turns out, you don’t need one in the host operating system itself.
Bottlerocket does, however, give you out-of-band access that allows you to launch a shell from a container to explore, debug, manually update, and change settings on the host.

## Host container out-of-band access

Since the software doesn’t exist on the host to facilitate interactive shell sessions, it is provided through a container.
These containers are granted access to resources on the underlying host, have the required software for remote connections, and are run in the host containerd instance.

### Control container

The control container’s purpose is to provide a first-tier host access where you can make API calls and gain access to some host-level resources.
For `aws-k8s-*` and `aws-ecs-*` variants, the control container is on by default and remote connections are made through AWS SSM.

The control container is also the path to enable or enter the admin container.

### Admin container

The admin container is designed to provide out-of-band access with elevated privileges.
On `aws-k8s-*` and `aws-ecs-*` variants, the admin container is not enabled by default but can be turned on or entered through the control container.
The best security practice is to disable the admin container and only enable it as-needed.

The admin container has read-only mount to the host file system, unrestricted an SELinux label as well as all of the capabilities of the control container.
Using the admin container should be rare: only used as-needed and by those required.

## With `kubectl` on Kubernetes

For variants designed to be used with Kubernetes, you can gain out-of-band access to a node by using `kubectl exec` and a pod spec with specific volume mounts and security contexts.
You can read more about this method in [Regaining Access to a Bottlerocket Node](../../login/regaining-access/).
This method is very similar to running the control container, but it runs in the orchestrated containerd instance instead of the host containerd instance.
