+++
title = "Operate & Observe"
type = "docs"
description = "Understanding the day-to-day use of ECS Updater" 
weight = 20
+++

By default, the ECS Updater runs every 12 hours (using the [default template](https://github.com/bottlerocket-os/bottlerocket-ecs-updater/blob/develop/stacks/bottlerocket-ecs-updater.yaml), schedule defined at at `.Resources.BottlerocketUpdaterSchedule.Properties.ScheduleExpression`).
Each time it runs, the ECS Updater creates a new log stream in Amazon CloudWatch Logs in the log group you specified when deploying.
You can view the logs in the [CloudWatch Logs Console](https://console.aws.amazon.com/cloudwatch/), with your own tools, or in the console.

## ECS Updater logs in the console

First, you’ll need to [retrieve the log stream](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/logs/describe-log-streams.html); likely you’re interested in the most recent update check.
Using the environment variables established in the Setup documentation, run the following command to get the most recent stream and store it in an environment variable:

```shell
export LAST_ECS_UPDATER_LOG_STREAM=$(aws logs describe-log-streams \
   --log-group-name ${ECS_UPDATER_LOG_GROUP} \
   --order-by LastEventTime \
   --query "logStreams[0].logStreamName" \
   --descending --no-cli-pager --output text --no-paginate)
```

Then confirm that the results look correct by running `echo $LAST_ECS_UPDATER_LOG_STREAM` , this should return something like `/ecs/bottlerocket-updater/some-ecs-cluster/BottlerocketEcsUpdaterService/0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a`

Once you have the `LAST_ECS_UPDATER_LOG_STREAM` environment variable, you can [get the events](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/logs/get-log-events.html):

```shell
aws logs get-log-events --log-group-name ${ECS_UPDATER_LOG_GROUP} \
   --log-stream-name ${LAST_ECS_UPDATER_LOG_STREAM} \
   --query "events[*].message" \
   --no-cli-pager --output table
```

This returns a table formatted list of the events, starting with the oldest and moving to the most recent.

A few notable messages and meanings:

* `Filtering container instances running Bottlerocket OS` and subsequently the message `Bottlerocket instance "i-<instance>" detected` .
You should see a match for all the Bottlerocket nodes in your ECS cluster.
* ECS Updater emits the message  `Filtering instances with available updates` when evaluating both the availability of of updates as well as the ability to drain the node.
* `Sending SSM document "bottlerocket-ecs-updater-UpdateApplyCommand...`  signals the start of ECS Updater directing the control container to apply the update.
* After finishing the update, the ECS Updater commands the control container to reboot, being logged as `Sending SSM document "bottlerocket-ecs-updater-RebootCommand...`
* Following the reboot, ECS Updater awaits the successful reboot and emits  `Waiting for instance "i-<instance>" to reach Ok status`
* Once reaching active, ECS Updater emits  `Container instance "arn:aws:ecs:<region>:<instance>:container-instance/<cluster>/<...>" state changed to ACTIVE successfully!`
* Before ensuring that the update happened correctly, ECS Updater logs `Verifying update by checking there is no new version available to update and validate the active version`
* In the scope of the frequency at which ECS Updater runs compared to the release cadence, most log streams end with “`No instances to update`”
