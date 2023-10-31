+++
title = "Locking to a Specific Release"
type = "docs"
description = "How to lock a Bottlerocket node to a specific release version"
+++

Locking your Bottlerocket nodes to a specific release is possible using the Bottlerocket Settings API.

_A quick explanation of the `apiclient` command used below:_

Two settings are set: `updates.version-lock` and `updates.ignore-waves`.

- `updates.version-lock`: which version of Bottlerocket to lock to when `apiclient` checks for updates.
- `updates.ignore-waves`: ignore the [update waves behavior](https://github.com/bottlerocket-os/bottlerocket/tree/develop/sources/updater/waves) and update the Bottlerocket node immediately.

To create an SSM Command Document, follow the steps in the [AWS Systems Manager User Guide: "Create an SSM document (console)"](https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-console.html).
Remember to select "YAML" in the "Content" box, since the [SSM Command Document below](#ssm-command-document-lock-to-a-specific-release) is formatted in YAML.

## SSM Command Document: Lock to a Specific Release

The following SSM Command Document is referred to in this documentation as `version-lock-bottlerocket-node`:

```yaml
---
schemaVersion: "2.2"
description: "Lock a Bottlerocket host to a specific version via the Bottlerocket Settings API"
parameters:
  TargetVersion:
    type: "String"
    description: "The target version of Bottlerocket to lock to (e.g. 1.12.0)"
mainSteps:
  - name: "setTargetVersion"
    action: "aws:runShellScript"
    inputs:
      timeoutSeconds: '20'
      runCommand:
        - "apiclient set updates.version-lock=\"{{ TargetVersion }}\" updates.ignore-waves=true"
```

You should now have the above SSM Command Document available in the SSM "Owned by me" tab in the "Documents" section of the SSM Console.

## Applying a Version Lock

In order to apply a version lock using SSM, follow these steps:

1. First, tell your Bottlerocket nodes that you want them to lock to a specific version.
    - Apply the [`version-lock-bottlerocket-node` SSM Command Document previously described](#ssm-command-document-lock-to-a-specific-release).
        - In the "Command parameters" section of the Run Command page, remember to specify the full version of Bottlerocket that you want to lock to (e.g. `1.12.0`, not `1.12`).
        - If you are using EKS, select all nodes in a given EKS cluster by specifying an instance tag in the "Target selection" section of the page.
        Specify `eks:cluster-name` as the tag key, with the tag value set to your cluster name.
2. Next, tell your Bottlerocket nodes to prepare to boot into that specific version.
    - Apply the [`update-bottlerocket-node` SSM Command Document](../methods/in-place/#ssm-command-document-check-for-and-apply-updates-to-a-bottlerocket-node), described in the [in-place update documentation](../methods/in-place/).
3. Finally, reboot your Bottlerocket nodes into the version you locked to.
    - Apply the [`reboot-bottlerocket-node` SSM Command Document](../methods/in-place/#ssm-command-document-reboot-a-bottlerocket-node), described in the [in-place update documentation](../methods/in-place/).

## Removing a Version Lock

In order to remove a version lock using SSM, [create](https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-console.html) and [apply](https://docs.aws.amazon.com/systems-manager/latest/userguide/running-commands-console.html) the following SSM Command Document to the Bottlerocket nodes you want to remove a Version Lock from (the SSM Command Document can be named `version-unlock-bottlerocket-node` for example):

### SSM Command Document: Remove a Version Lock

```yaml
---
schemaVersion: "2.2"
description: "Remove a Version Lock from a Bottlerocket host via the Bottlerocket Settings API"
mainSteps:
  - name: "unsetTargetVersion"
    action: "aws:runShellScript"
    inputs:
      timeoutSeconds: '20'
      runCommand:
        - "apiclient set updates.version-lock=\"latest\" updates.ignore-waves=false"
```
