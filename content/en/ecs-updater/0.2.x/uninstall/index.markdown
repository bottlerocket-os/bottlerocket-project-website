+++
title = "Uninstall"
type = "docs"
description = "Removing ECS Updater from your cluster" 
+++

To uninstall ECS Updater, delete the AWS CloudFormation stack that you previously deployed.
Assuming you have the environment variables set from the previous install guide, run the following:

```shell
aws cloudformation delete-stack \
    --stack-name ${ECS_UPDATER_STACK} \
    --region ${AWS_REGION}
```

With no errors, this will give no return status.

To confirm the removal of ECS Updater, describe the stack:

```shell
aws cloudformation describe-stacks --stack-name ${ECS_UPDATER_STACK}
```

If deleted, the CLI returns `An error occurred (ValidationError) when calling the DescribeStacks operation Stack with id <...> does not exist` , otherwise it will show the stack, indicating a still active ECS Updater.
If you followed the Setup instructions and created a log group, make sure and clean that up as well.
