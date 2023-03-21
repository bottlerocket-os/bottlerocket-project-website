+++
title="Getting Started: Amazon EKS"
type="docs"
description="How to get started with Bottlerocket on Amazon EKS"
+++

## Dependencies

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

Get a cup of coffee, it will take a while to provision your control plane and cluster nodes. ☕️

## Test Your Cluster

To confirm that Bottlerocket nodes are running in your cluster, you can run the following command to get an instance ID from any one of the nodes in the cluster:

```bash
kubectl describe nodes | grep ProviderID
```

The instance IDs will start with `i-`.
Pick any one of the instance IDs you see since all the nodes in the cluster should be the same.

Then, run the following command to enter an SSM session on the node:

```bash
aws ssm start-session --target INSTANCE_ID
```

Replace `INSTANCE_ID` with the instance ID you picked earlier.

Entering the SSM session will place you in the control container.
Enter the admin container:

```bash
enter-admin-container
```

Then, enter a shell on the Bottlerocket host:

```bash
sudo sheltie
```

Confirm you're running Bottlerocket with the following command in the Bottlerocket host shell:

```bash
cat /etc/os-release
```

You should see output similar to the following:

```bash
NAME=Bottlerocket
ID=bottlerocket
VERSION="1.12.0 (aws-k8s-1.25)"
PRETTY_NAME="Bottlerocket OS 1.12.0 (aws-k8s-1.25)"
VARIANT_ID=aws-k8s-1.25
...
```

Congratulations!
You now have a Bottlerocket cluster running on EKS.
