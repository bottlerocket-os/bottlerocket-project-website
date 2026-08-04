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

The script takes a single flag-based argument:
- `-b`: Bottlerocket version in X.Y.Z format
- `-h`: Show help message

The core-kit and kernel-kit versions are automatically extracted from the `Twoliter.toml` file in the Bottlerocket repository at the specified version tag.

For example, if you want to update the website for Bottlerocket version 1.40.0:

```bash
./update_website.sh -b 1.40.0
```

The script will:
1. Clone the Bottlerocket repository at the specified version tag
2. Extract `bottlerocket-core-kit` and `bottlerocket-kernel-kit` versions from `Twoliter.toml`
3. Clone the core-kit and kernel-kit repositories at the extracted versions
4. Copy content from the previous minor version (e.g., 1.39.x to 1.40.x)
5. Update version labels in the content
6. Generate new package version data, NVIDIA information, and kernel version information
7. Clean up temporary files when complete
