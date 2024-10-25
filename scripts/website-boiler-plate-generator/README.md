# Script: Copy documentation from previous minor version to current minor version

This script is used to generate the data for `content/[lang]/os/[version]/` and `data/settings/[version]`. You will need to run it on every minor version before running any other script.

## Prerequisites

This script works on Linux or MacOS and is unlikely to work in Windows.

## Running the script

There is one script in this directory:

- `copy_files_from_prev_version.sh`: Copies contents from previous minor version to current minor version and removes unnecessary files. The only argument it accepts is the version (usually the latest) for which we want to copy content.

### Usage

As an example, if we want to copy the contents from 1.25 to 1.26, then, you can run the following:

```bash
./copy_files_from_prev_version.sh 1.26.0
```
