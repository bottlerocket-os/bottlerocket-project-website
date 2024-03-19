+++
title = "Setup"
type = "docs"
description = "Steps to install ECS Updater on your cluster"
weight = 10
+++

This guide assumes you have [AWS CLI v2](https://aws.amazon.com/cli/) installed on a Unix-like system and that you’re authenticated into an account with the requisite permissions.

{{% alert title="Note" color="secondary" %}}
Environment variable names in this guide do not have specific meaning; you can replace them with your own or directly interpolate your values as needed.
{{% /alert %}}

## Define your environment

First, define your region in an environment variable.
Customize the value of this variable for whatever region in which your particular [Amazon ECS](https://aws.amazon.com/ecs/) cluster resides.

```shell
export AWS_REGION=us-west-2
```

## Set your cluster name

Now, set an environment variable name `ECS_UPDATER_CLUSTER` with the name of the ECS cluster you want to update.

```shell
export ECS_UPDATER_CLUSTER=my-cluster-to-update
```

Confirm that you have a valid cluster name by running the following:

```shell
aws ecs describe-clusters --no-cli-pager \
    --region ${AWS_REGION} \
    --cluster ${ECS_UPDATER_CLUSTER}
```

This should return JSON [describing the information about your cluster](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ecs/describe-clusters.html).
If the returned JSON has an empty `clusters` element and populated `failures` element, double check your cluster name.

## VPCs and Subnets

If you’re **using the default VPC**, this command stores it in the environment variable `ECS_UPDATER_VPC` :

```shell
export ECS_UPDATER_VPC=$(aws ec2 describe-vpcs \
    --no-cli-pager \
    --output text \
    --region ${AWS_REGION} \
    --filters=Name=isDefault,Values=true \
    --query "Vpcs[0].VpcId")
```

Alternately, **if you want a specific VPC by name**, store that name in the environment variable `ECS_UPDATER_VPC_NAME` , replacing ‘myvpc’ with the name of your specific VPC.

```shell
export ECS_UPDATER_VPC_NAME=myvpc
```

Then run the following command:

```shell
export ECS_UPDATER_VPC=$(aws ec2 describe-vpcs \
    --no-cli-pager \
    --output text \
    --region ${AWS_REGION} \
    --filters=Name=tag:Name,Values=${ECS_UPDATER_VPC_NAME} \
    --query "Vpcs[0].VpcId")
```

Double check that the output matches what you’d expect by running `echo $ECS_UPDATER_VPC`.
It should return something like `vpc-0a0a0a0a0a0a0a0a0` .

Now, with the `ECS_UPDATER_VPC`  environment variable, you’ll need to select the subnets.
To get a [list of your subnets](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/describe-subnets.html) with the requisite information, run the following:

```shell
 aws ec2 describe-subnets \
   --no-cli-pager \
   --output table \
   --region ${AWS_REGION} \
   --filter=Name=vpc-id,Values=${ECS_UPDATER_VPC} \
    --query "Subnets[].{id: SubnetId, public: MapPublicIpOnLaunch, az: AvailabilityZone}"
```

This returns a formatted table for each subnet in the VPC along with their ID, availability zone, and a boolean if the subnet is public or not.
From this table you’ll need to select at least one in each availability zone listed and put the IDs into a comma separated environment variable `ECS_UPDATER_SUBNETS` .
For example, you might end up with something like `export ECS_UPDATER_SUBNETS=subnet-0c0c0c0c0c0c0c0c0,subnet-0b0b0b0b0b0b0b0cb`

{{% alert title="Requirement" color="warning" %}}
ECS Updater requires access to the internet to gather dependencies. [Public subnets need an internet gateway and private subnets require NAT configuration.](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)
{{% /alert %}}

## Add a log group

ECS Updater requires an [Amazon CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html) group to record output.
You can use either an existing log group or create a new log group.

### Create a log group

To create a new log group, first define the name of the log group:

```shell
export ECS_UPDATER_LOG_GROUP="my-log-group"
```

Then [create the group](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/logs/create-log-group.html):

```shell
aws logs create-log-group --log-group-name ${ECS_UPDATER_LOG_GROUP}
```

A successful log group creation may not return any values, so make sure and confirm the details about your group.

### Use an existing log group

Run the following to get a [list of your available log groups](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/logs/describe-log-groups.html):

```shell
aws logs describe-log-groups \
    --no-cli-pager \
    --query "logGroups[*].logGroupName" \
    --output table
```

This should return a single-column, formatted table of your log groups.
Select the log group you want and then set the  `ECS_UPDATER_LOG_GROUP` to the name of the group you wish to use.

```shell
export ECS_UPDATER_LOG_GROUP="my-log-existing"
```

To make sure you transcribed the log group name correctly, confirm the details about your group.

### Confirm the log group

To confirm that your log group environment variable is valid, run the following:

```shell
aws logs describe-log-groups \
    --no-cli-pager \
    --query "logGroups[?logGroupName == '${ECS_UPDATER_LOG_GROUP}']"
```

This should return some JSON including the element `logGroupName`  populated with your log group.
If you get `[]` as a return value, double check your log group name.

## Install and deploy the template

First set an environment variable to define the stack name:

```shell
export ECS_UPDATER_STACK="bottlerocket-ecs-updater"
```

Next, get the [AWS CloudFormation template from the ECS Updater GitHub repo](https://github.com/bottlerocket-os/bottlerocket-ecs-updater/blob/develop/stacks/bottlerocket-ecs-updater.yaml) and save it to your working directory or use  curl to retrieve the file directly:

```shell
curl https://raw.githubusercontent.com/bottlerocket-os/bottlerocket-ecs-updater/v0.2.3/stacks/bottlerocket-ecs-updater.yaml > bottlerocket-ecs-updater.yaml
```

Then [deploy the stack](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/deploy/index.html) using the environment variables you previously set above:

```shell
aws cloudformation deploy \
    --stack-name ${ECS_UPDATER_STACK} \
    --template-file  ./bottlerocket-ecs-updater.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
    ClusterName=${ECS_UPDATER_CLUSTER} \
    Subnets=${ECS_UPDATER_SUBNETS} \
    LogGroupName=${ECS_UPDATER_LOG_GROUP}
```

This should return something like:

```shell
Waiting for changeset to be created..
Waiting for stack create/update to complete
Successfully created/updated stack - bottlerocket-ecs-updater
```

With this, you’ve successfully deployed the ECS Updater to your cluster.

## Also see

* The pattern [Amazon ECS cluster on Bottlerocket Operating System](https://containersonaws.com/pattern/ecs-ec2-bottlerocket-cluster) contains instructions on how to deploy a Bottlerocket cluster with ECS Updater using [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html)