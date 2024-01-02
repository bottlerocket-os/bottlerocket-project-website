+++
title="Amazon EKS"
type="docs"
description="How to get started with Bottlerocket on Amazon EKS"
+++

{{< hide-and-re-highlight-menu link_url="/en/os/%s/install/quickstart/" depad="true" >}}
{{< hide-and-re-highlight-menu link_url="/en/os/%s/install/quickstart/aws/" depad="true" >}}
{{< breadcrumb-remove link_url="/en/os/%s/install/quickstart/">}}
{{< breadcrumb-remove link_url="/en/os/%s/install/quickstart/aws/">}}


## Prerequisites

In order to set up a Bottlerocket cluster on EKS, you will need the latest versions of the following tools installed:

- [`eksctl`](https://eksctl.io/): Used to create EKS clusters.
- [`kubectl`](https://kubernetes.io/docs/tasks/tools/#kubectl): Used to interact with resources within a Kubernetes cluster.
- [`aws-cli`](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions): Used to interact with AWS services.
- [SSM Session Manager Plugin for AWS CLI](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html): Used to enter SSM sessions on Bottlerocket nodes through the AWS CLI.

## Cluster Setup

There are two main steps to setting up an EKS cluster: creating the configuration file and applying the configuration file using `eksctl`.

### Cluster Configuration File

`eksctl` can use a YAML configuration file to create an EKS cluster.
First, set some environment variables:

- `AWS_REGION`: AWS region to create the cluster in.
- `K8S_VERSION`: Kubernetes version to use for the cluster.
- `EKS_CLUSTER_NAME`: Name of the EKS cluster to create.

```bash
export AWS_REGION="us-west-2"
export K8S_VERSION="1.25"
export EKS_CLUSTER_NAME="bottlerocket-quickstart-eks"
```

The following command (on Linux and macOS) will create an example configuration file named `bottlerocket-quickstart-eks.yaml` that specifies a cluster with 3 Bottlerocket nodes:

```bash
cat << EOF > bottlerocket-quickstart-eks.yaml
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: $EKS_CLUSTER_NAME
  region: $AWS_REGION
  version: "$K8S_VERSION"

nodeGroups:
  - name: ng-bottlerocket-quickstart
    instanceType: m5.large
    desiredCapacity: 3
    amiFamily: Bottlerocket
    iam:
       attachPolicyARNs:
          - arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
          - arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
          - arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
          - arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
    bottlerocket:
      settings:
        motd: "Hello from eksctl!"
EOF
```

On Windows, you will need to create this file in a text editor and replace `$EKS_CLUSTER_NAME`, `$AWS_REGION`, and `$K8S_VERSION` with your desired values.
The contents to copy are _between_ the `cat << EOF > bottlerocket-quickstart-eks.yaml` and `EOF` lines.

### Cluster Creation

Start the cluster creation process using the configuration file you created in the last step (`bottlerocket-quickstart-eks.yaml` in this example):

```bash
eksctl create cluster --config-file ./bottlerocket-quickstart-eks.yaml
```

Get a cup of coffee ☕️, it will take a while to provision your control plane and cluster nodes.

## Confirm Your Cluster is Running

To confirm that Bottlerocket nodes are running in your cluster, you can run the following command to list your cluster nodes and what operating system they are running:

```bash
kubectl get nodes -o=wide
```

You should see output that contains a column similar to the following:

```bash
... OS-IMAGE                              ...
    Bottlerocket OS 1.12.0 (aws-k8s-1.25)
    Bottlerocket OS 1.12.0 (aws-k8s-1.25)
    Bottlerocket OS 1.12.0 (aws-k8s-1.25)
```

Next, get an instance ID from any one of the nodes in the cluster (remember that `$EKS_CLUSTER_NAME` is set to the name of your EKS cluster):

```bash
aws ec2 describe-instances  --no-cli-pager --filters "Name=tag:aws:eks:cluster-name,Values=$EKS_CLUSTER_NAME" --query "Reservations[*].Instances[*].{PrivateDNS:PrivateDnsName,InstanceID:InstanceId,Cluster:Tags[?Key=='aws:eks:cluster-name']|[0].Value,State:State.Name}" --output=table
```

You should see output that contains a column similar to the following:

```bash
    +----------------------+
... |     InstanceID       | ...
    +----------------------+
    |  i-04c2b2087...      |
    |  i-0e61e2b0a...      |
    |  i-022aca952...      |
    +----------------------+
```

## Interacting With Your Cluster

To confirm in depth that an instance is running Bottlerocket, pick an instance ID and follow the steps in the [Host Containers Quickstart](../host-containers).
Any of the instance IDs listed for the `bottlerocket-quickstart-eks` cluster should work.

Congratulations!
You now have a Bottlerocket cluster running on EKS.

{{< on-github >}}
