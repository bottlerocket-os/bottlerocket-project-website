+++
title="Amazon ECS"
type="docs"
description="How to get started with Bottlerocket on Amazon ECS"
+++

{{< hide-and-re-highlight-menu link_url="/en/os/%s/install/quickstart/" depad="true" >}}
{{< hide-and-re-highlight-menu link_url="/en/os/%s/install/quickstart/aws/" depad="true" >}}
{{< breadcrumb-remove link_url="/en/os/%s/install/quickstart/">}}
{{< breadcrumb-remove link_url="/en/os/%s/install/quickstart/aws/">}}

When registering EC2 instances as capacity for an ECS cluster, you can use Bottlerocket as the operating system for these instances.
If you want to understand the AWS console workflow, start with the [video _Amazon ECS: Using Bottlerocket_.](#aws-console-quickstart)
Otherwise, read the [AWS CLI Quickstart](#aws-cli-quickstart) or the pattern [Amazon ECS cluster on Bottlerocket](https://containersonaws.com/pattern/ecs-ec2-bottlerocket-cluster) which outlines how to start Bottlerocket with [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/).

## AWS CLI Quickstart

This quickstart uses a number of techniques/tools like `jq` and environment variables to make the quickstart experience as simple and straightforward as possible.
These tools are not absolutely necessary to use Bottlerocket on ECS.

### Prerequisites

There are some preliminary tasks to complete in order to use ECS.
You need to both set up your AWS account for use with ECS and have an IAM role for ECS configured:

- Complete the steps in [Setting up with Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/get-set-up-for-amazon-ecs.html).
- Ensure that the AWS user you use for this quickstart has the has the [AmazonECS_FullAccess](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/security-iam-awsmanpol.html#security-iam-awsmanpol-AmazonECS_FullAccess) policy attached (scope down as needed for your production requirements).
- Ensure that you have an [IAM role created](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html#instance-iam-role-create) named `ecsInstanceRole` and configured according to the AWS ECS Developer Guide.
  - Be sure to follow _both_ the [AWS Console steps](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html#instance-iam-role-create) as well as the AWS CLI steps (section labeled "To create the ecsInstanceRole role (AWS CLI)" - the AWS CLI steps cover an important aspect: adding an Instance Profile to the role)

In this quickstart, the following software is used to interact with AWS and parse the responses received:

- [`aws-cli`](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions): Used to interact with AWS services.
- [`jq`](https://stedolan.github.io/jq/download/): Used for parsing response data from `aws-cli`.

### Create a Cluster

First, set some environment variables to use throughout this quickstart:

```bash
export AWS_REGION=us-west-2
export ECS_CLUSTER_NAME=bottlerocket-quickstart-ecs
export ECS_INSTANCE_ROLE_NAME=ecsInstanceRole
```

Then, create an ECS cluster with the AWS CLI as follows:

```bash
aws ecs --region $AWS_REGION create-cluster --cluster-name $ECS_CLUSTER_NAME
```

You should see output confirming your new cluster similar to the following:

```json
{
    "cluster": {
        "clusterArn": "arn:aws:ecs:us-west-2:xxxxxxxxxxxx:cluster/bottlerocket-quickstart-ecs",
        "clusterName": "bottlerocket-quickstart-ecs",
        "status": "ACTIVE",
        "registeredContainerInstancesCount": 0,
        "runningTasksCount": 0,
        "pendingTasksCount": 0,
        "activeServicesCount": 0,
        "statistics": [],
        "tags": [],
        "settings": [
            {
                "name": "containerInsights",
                "value": "disabled"
            }
        ],
        "capacityProviders": [],
        "defaultCapacityProviderStrategy": []
    }
}
```

### Launching Instances Into Your Cluster

After your ECS cluster is created, you can add instances to it.

#### Enabling SSM

Enable SSM on the `ecsInstanceRole` IAM role by attaching the `AmazonSSMManagedInstanceCore` managed policy to the role:

```bash
aws iam attach-role-policy \
   --role-name $ECS_INSTANCE_ROLE_NAME \
   --policy-arn arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
```

#### Connecting To Your Cluster

In order to communicate with ECS, configure each node with the name of the cluster.
The following command will create a file named `quickstart-ecs-user-data.toml` with the appropriate contents:

```bash
cat << EOF > quickstart-ecs-user-data.toml
[settings.ecs]
cluster = "$ECS_CLUSTER_NAME"
EOF
```

#### Launch

Now you can add Bottlerocket instances to your ECS cluster!
There are some values that you need to set in your environment first such as the Subnet ID, Bottlerocket AMI ID, and ECS Instance Profile Name.
You can get the information you need using the AWS CLI:

```bash
export ECS_VPC_ID=$(aws ec2 describe-vpcs \
   --region $AWS_REGION \
   --filters=Name=isDefault,Values=true \
   | jq --raw-output '.Vpcs[].VpcId')
export ECS_SUBNET_ID=$(aws ec2 describe-subnets \
   --region $AWS_REGION \
   --filter=Name=vpc-id,Values=$ECS_VPC_ID \
   | jq --raw-output '.Subnets[0] | {id: .SubnetId, public: .MapPublicIpOnLaunch, az: .AvailabilityZone} | .id')
export BOTTLEROCKET_AMI_ID="resolve:ssm:/aws/service/bottlerocket/aws-ecs-2/x86_64/latest/image_id"
export ECS_INSTANCE_PROFILE_NAME=$(aws iam list-instance-profiles-for-role \
   --role-name $ECS_INSTANCE_ROLE_NAME \
   --query "InstanceProfiles[*].InstanceProfileName" \
   --output text)
```

Then launch an instance into your cluster:

```bash
aws ec2 run-instances \
   --subnet-id $ECS_SUBNET_ID \
   --image-id $BOTTLEROCKET_AMI_ID \
   --instance-type m5.large \
   --region $AWS_REGION \
   --tag-specifications "ResourceType=instance,Tags=[{Key=ecs-cluster,Value=$ECS_CLUSTER_NAME}]" \
   --user-data file://quickstart-ecs-user-data.toml \
   --iam-instance-profile Name=$ECS_INSTANCE_PROFILE_NAME
```

Once the instance launches, you should be able to run tasks on your Bottlerocket instance using either the ECS API or web console.

### Confirming Your Instances Are Running

To confirm that nodes are running in your cluster, you can run the following command to list your ECS cluster nodes:

```bash
aws ec2 describe-instances \
   --no-cli-pager \
   --filters "Name=tag:ecs-cluster,Values=$ECS_CLUSTER_NAME" \
   --query "Reservations[*].Instances[*].{PrivateDNS:PrivateDnsName,InstanceID:InstanceId,Cluster:Tags[?Key=='ecs-cluster']|[0].Value,State:State.Name}" \
   --output=table
```

You should see output that contains a column similar to the following:

```bash
    +----------------------+
... |     InstanceID       | ...
    +----------------------+
    |  i-04c2b2087...      |
    +----------------------+
```

### Interacting With Your Cluster

To confirm in depth that an instance is running Bottlerocket, save the instance ID and follow the steps in the [Host Containers Quickstart](../host-containers).

Congratulations!
You now have a Bottlerocket cluster running on ECS.

{{< on-github >}}

## AWS Console Quickstart

If you want to start an ECS cluster using EC2 nodes running Bottlerocket, the follow video provides a high level walk through.
{{< youtube c4hhZZwSrP0 >}}
