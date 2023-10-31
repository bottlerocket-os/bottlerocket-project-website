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

{{% alert title="Warning" color="warning" %}}
The solutions on this page provide a minimal overview.
It involves mounting critical resources into containers with elevated privileges.
Use carefully, only run as long as necessary, and clean up afterwards.
{{% /alert %}}

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

You can regain access to a Bottlerocket node using ECS Exec starting in v1.14.0.

This solution requires the use of [ECS Exec](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-exec.html) and [associated IAM permissions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-exec.html#ecs-exec-enabling-and-using).
The instructions for proper IAM permissions to enable ECS Exec can be found in the AWS blog post [Using Amazon ECS Exec to access your containers on AWS Fargate and Amazon EC2](https://aws.amazon.com/blogs/containers/new-using-amazon-ecs-exec-access-your-containers-fargate-ec2/).

1. First, you will need to setup a few environment variables. `CONTAINER_NAME` and `SERVICE_NAME` are not specifically relevant, but they need to be consistent across multiple files and commands.

```shell
export CONTAINER_NAME="regain-access"
export CLUSTER=<your cluster name>
export SERVICE_NAME="regain-access"
export TASK_ROLE_ARN=<the ARN for your IAM task role>
```

2. Now you will create a task definition that will mount the Bottlerocket `apiclient` and the related socket path as well as giving it the proper SELinux labels.
Piping `cat` to a file to generate the task definition[^1] JSON will allow for interpolating the variables into the final file.

```shell
cat << EOF > task-def.json 
{
    "family": "regain-access",
    "containerDefinitions": [
        {
            "name": "${CONTAINER_NAME}",
            "image": "fedora",
            "cpu": 0,
            "memoryReservation": 300,
            "portMappings": [],
            "essential": true,
            "command": ["sleep", "infinity"],
            "environment": [],
            "mountPoints": [
                {
                    "sourceVolume": "apiclient",
                    "containerPath": "/usr/bin/apiclient",
                    "readOnly": true
                },
                {
                    "sourceVolume": "apisocket",
                    "containerPath": "/run/api.sock"
                }
            ],
            "volumesFrom": [],
            "dockerSecurityOptions": [
                "label:user:system_u",
                "label:role:system_r",
                "label:type:control_t",
                "label:level:s0"
            ]
        }
    ],
    "taskRoleArn": "${TASK_ROLE_ARN}",
    "volumes": [
        {
            "name": "apiclient",
            "host": {
                "sourcePath": "/usr/bin/apiclient"
            }
        },
        {
            "name": "apisocket",
            "host": {
                "sourcePath": "/run/api.sock"
            }
        }
    ],
    "requiresCompatibilities": [
        "EC2"
    ],
    "cpu": "1024",
    "memory": "1024"
}
EOF
```

3. The following will take the file from the previous step and use the AWS CLI to register the task definition.
Running the AWS CLI command without any options, will produce a large amount of JSON that is hard to sift through. Instead, use the `query` parameter to get only what you need, format the output text and skip the pager.
Then take the results and put it into another environment variable. Any errors will be visible as a response in standard output.

```shell
export REGAIN_ACCESS_ARN=$(aws ecs register-task-definition \
  --cli-input-json file://task-def.json \
  --query "taskDefinition.taskDefinitionArn" \
  --output text --no-cli-pager)
```

4. As a confidence check, `echo` the environment variable to make sure it matches what you’d expect from an ARN.

```shell
echo $REGAIN_ACCESS_ARN
```

5. With the task definition ARN stored in the environment variable, you can create the service. You may want to limit the deployment of this service to specific instance(s).

```shell
aws ecs create-service --cluster "${CLUSTER}" \
    --task-definition "${REGAIN_ACCESS_ARN}" \
    --service-name "${SERVICE_NAME}" \
    --desired-count 1 \
    --launch-type EC2 \
    --enable-execute-command \
    --no-cli-pager
```

6. The subsequent step will need the task ARN which is not included in the response from the `create-service` call; the command below will grab all the task ARNs from the service name and cluster you specified earlier (which should only be one), filter the response with the `query` parameter, and use an environment variable to store only what you need.
Wait a few seconds after the previous step and run the following command:

```shell
export TASK_ARN=$(aws ecs list-tasks --cluster ${CLUSTER} \
  --service-name ${SERVICE_NAME} \
  --no-cli-pager \
  --output text \
  --query "taskArns[0]")
```

7. Again, do a confidence check to ensure the environment variable looks as you’d expect.

```shell
echo $TASK_ARN
```

8. Finally, you can use `execute-command` to open an interactive shell with the container.

```shell
aws ecs execute-command --cluster "${CLUSTER}" \
    --task "${TASK_ARN}" \
    --container "${CONTAINER_NAME}" \
    --interactive \
    --command /bin/bash"
```

9. You should see a message like this followed by an interactive shell

```shell
Starting session with SessionId: ecs-execute-command-<some hex values>
```

10. In the shell use `apiclient` to enable the [admin container](https://github.com/bottlerocket-os/bottlerocket-admin-container#authenticating-with-the-admin-container), [control container](https://github.com/bottlerocket-os/bottlerocket-control-container#connecting-to-aws-systems-manager-ssm), or both.


```bash
# Admin container
apiclient set host-containers.admin.enabled=true
```

```bash
# Control container:
apiclient set host-containers.control.enabled=true
```

11. Now you should be able to access your admin or control container using SSM. You no longer need anything created in this how-to, feel free to delete the service and IAM policies.

[^1]: This task definition uses `fedora` as an image, but almost any base image with a shell will also work.
