+++
title="cloudformation"
type="docs"
toc_hide=true
description="Settings related to CloudFormation signaling (`settings.cloudformation.*`)"
+++

You can setup Bottlerocket to send successful host creation or update signals to [AWS CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html).

{{% alert title="Note" color="success" %}}
These setting only function on `aws-*` variants.
{{% /alert %}}

{{< settings >}}
