# Script: NVIDIA version information

This script is used to generate the file and data for `[lang]/os/[version line]/version-information/gpu-drivers/[full version]`. You will need to run it on every minor version.

## Prerequisites

This script works on Linux or MacOS and is unlikely to work in Windows. The directory structure used in the script specifically ties to bottlerocket-os/bottlerocket; it's unlikely to work in any other context.

Before you begin, clone bottlerocket-os/bottlerocket outside the project-website directory.

## Running the scripts

There are three scripts in this directory:

- `get_cargos.sh`: find all the variant's NVIDIA `Cargo.toml` files inside the [bottlerocket repo](https://github.com/bottlerocket-os/bottlerocket/tree/develop/packages/) and run `create_data_file_from_cargo.sh` on each.
- `create_data_file_from_cargo.sh`: Read a single `Cargo.toml` file and copy/transform it into a hugo data file.
- `create_markdown.sh`: Creates the markdown file for `[lang]/os/[version line]/version-information/gpu-drivers/[full version]`

### Copy/transform all `Cargo.toml` files into a hugo data files

This script will find all the `Cargo.toml` files in the specified path and run `create_data_file_from_cargo.sh` for each.

Make the sure the directory in the second argument exists already.

```bash
./get_cargos.sh /path/to/bottlerocket-repo /path/to/website/data/nvidia/1.15.1/
```

(Note the lack of a trailing slash on the first argument and the inclusion of a trailing slash on the second. This is important.)

This will create a new data file for each package in `/path/to/bottlerocket-repo/packages/` that matches the pattern `kmod-<version number>-nvidia`.

### Create the page

Create the markdown page which will make the data visible.

```bash
./create_markdown.sh /path/to/site/content/en/os/1.15.x/version-information/gpu-drivers 1.15.2
```
