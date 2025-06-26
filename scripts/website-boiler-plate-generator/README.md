# Script: Update Bottlerocket Website Content

This script is used to update the Bottlerocket website content for a new version. It copies data from the previous minor version, updates version labels, and generates new content for `content/[lang]/os/[version]/` and `data/settings/[version]`.

## Prerequisites

- This script works on Linux or MacOS and is unlikely to work in Windows.
- Git must be installed and configured with access to the Bottlerocket repositories.
- You need internet access to clone the required repositories.

## Running the script

There is one script in this directory:

- `update_website.sh`: Updates website content for a new Bottlerocket version. It copies content from the previous minor version, updates version labels, and generates new content including package information, NVIDIA driver data, and kernel version information.

### Usage

The script requires three arguments:
1. `bottlerocket-version`: The new Bottlerocket version in X.Y.Z format
2. `core-kit-version`: The Core Kit version in X.Y.Z format
3. `kernel-kit-version`: The Kernel Kit version in X.Y.Z format

For example, if you want to update the website for Bottlerocket version 1.26.0 with Core Kit version 1.5.0 and Kernel Kit version 5.10.118:

```bash
./update_website.sh 1.40.0 8.2.0 2.5.1
```

The script will:
1. Clone the necessary repositories at the specified versions
2. Copy content from the previous minor version (e.g., 1.25.x to 1.26.x)
3. Update version labels in the content
4. Generate new package version data, NVIDIA information, and kernel version information
5. Clean up temporary files when complete
