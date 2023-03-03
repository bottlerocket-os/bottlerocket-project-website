+++
title = "Regaining Access to a Bottlerocket Node"
description = "How to Regain Access to a Bottlerocket Node After Disabling the Control and Admin Containers"
type = "docs"
+++

## Introduction

The standard way to access a shell on a Bottlerocket node is to use either the admin container or the control container.
In some cases where both the admin and control containers are disabled, it is still possible to regain access to a Bottlerocket node.

## Solution Description

In general, the solution is to mount the [API client](https://github.com/bottlerocket-os/bottlerocket/blob/develop/sources/api/apiclient/README.md) and API socket into a container on the Bottlerocket node and use the API client to re-enable the admin container, control container, or both.

## Steps to Regain Access on Kubernetes

1. Create a pod that mounts the API client and API socket with the correct SELinux labels.

    Some notes on the Pod spec below:

    - The API socket has a specific SELinux label applied to it (`system_u:object_r:api_socket_t:s0`) that restricts access to the `api_socket_t` type and `s0` sensitivity level.
    To learn more about the SELinux labels in Bottlerocket, see the [Security Guidance documentation](https://github.com/bottlerocket-os/bottlerocket/blob/develop/SECURITY_GUIDANCE.md#limit-use-of-privileged-selinux-labels).
    - In order to access the API socket, the Pod must have compatible SELinux options applied to it.
    - Use the `control_t` type (has access to `api_socket_t`) and `s0` sensitivity level to allow the container to access the API socket.
    - The entrypoint for the container is `sleep infinity` so that the container stays running for you to `exec` into.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: regain-access
spec:
  containers:
  - name: regain-access
    image: fedora
    command: ["sleep", "infinity"]
    volumeMounts:
      - mountPath: /usr/bin/apiclient
        name: apiclient
        readOnly: true
      - mountPath: /run/api.sock
        name: apiserver-socket
    securityContext:
      seLinuxOptions:
        level: s0
        role: system_r
        type: control_t
        user: system_u
  volumes:
    - name: apiclient
      hostPath:
        path: /usr/bin/apiclient
        type: File
    - name: apiserver-socket
      hostPath:
        path: /run/api.sock
        type: Socket
```

2. `exec` into the container.

```bash
kubectl exec -it regain-access -- bash
```

3. Use `apiclient` to enable the [admin container](https://github.com/bottlerocket-os/bottlerocket-admin-container#authenticating-with-the-admin-container), [control container](https://github.com/bottlerocket-os/bottlerocket-control-container#connecting-to-aws-systems-manager-ssm), or both.

Admin container:

```bash
apiclient set host-containers.admin.enabled=true
```

Control container:

```bash
apiclient set host-containers.control.enabled=true
```

4. Exit the shell and delete the `regain-access` pod.
The Bottlerocket node should be accessible again.

## Steps to Regain Access on ECS

Bottlerocket does not _yet_ support `ecs exec`, so this solution to regain access does not yet work on ECS.
