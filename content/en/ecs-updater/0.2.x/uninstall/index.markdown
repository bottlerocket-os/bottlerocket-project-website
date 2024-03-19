+++
title = "Uninstall"
type = "docs"
description = "Removing ECS Updater from your cluster" 
weight = 40
+++

To uninstall ECS Updater, [delete](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/delete-stack.html) the [AWS CloudFormation](https://aws.amazon.com/cloudformation/) stack that you previously deployed.
Assuming you have the environment variables set from the previous install guide, run the following:

```shell
aws cloudformation delete-stack \
    --stack-name ${ECS_UPDATER_STACK} \
    --region ${AWS_REGION}
```

With no errors, this will give no return status.

To confirm the removal of ECS Updater, [describe the stack](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/describe-stacks.html):

```shell
aws cloudformation delete-stack --stack-name ${ECS_UPDATER_STACK}
```

If deleted, the CLI returns `An error occurred (ValidationError) when calling the DescribeStacks operation Stack with id <...> does not exist` , otherwise it will show the stack, indicating a still active ECS Updater.

If you followed the [Setup instructions](../setup/) and created a log group, make sure and [clean that up](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/logs/delete-log-group.html) as well.
