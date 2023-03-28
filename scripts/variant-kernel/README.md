# Script: Variant Kernel Information

This script is used to generate the data for `[lang]/os/[version]/version-information/variants/`. You will need to run it on every minor version.

## Prerequisites

This script works on Linux or MacOS and is unlikely to work in Windows. The directory structure used in the script specifically ties to bottlerocket-os/bottlerocket; it's unlikely to work in any other context.

Before you begin, clone bottlerocket-os/bottlerocket outside the project-website directory.

## Running the scripts

There are two scripts in this directory:

- `get_cargos.sh`: find all the variant's `Cargo.toml` files inside the [bottlerocket repo](https://github.com/bottlerocket-os/bottlerocket/tree/develop/variants) and run `create_data_file_from_cargo.sh` on each.
- `create_data_file_from_cargo.sh`: Read a single `Cargo.toml` file and copy/transform it into a hugo data file.

If you are experimenting, you probably want to use `create_data_file_from_cargo.sh` as this will create a single file rather than multiple.

### Copy/transform a single `Cargo.toml` into a hugo data file

As an example, if you want to create a hugo data file for the `aws-k8s-1.26` variant you can run the following:

```bash
./create_data_file_from_cargo.sh /path/to/bottlerocket-repo/variants/aws-k8s-1.26/Cargo.toml /path/to/website/data/variants/1.13.x/
```

The last part (`/data/variants/1.13.x/`) is relevant and should only be changed based on the version. The trailing slash is also required. This will put a single file `path/to/website/data/variants/1.13.x/aws-k8s-1.26.toml` that is an annotated version of `/path/to/bottlerocket-repo/variants/aws-k8s-1.26/Cargo.toml`.

### Copy/transform all `Cargo.toml` files into a hugo data files

To avoid needing to run the previous script multiple times, the `get_cargos.sh` script is included. It will find all the `Cargo.toml` files in the specified path and run `create_data_file_from_cargo.sh` for each.

```bash
./get_cargos.sh /path/to/bottlerocket-repo/variants /path/to/website/data/variants/1.13.x/
```

This will create a new data file for each variant in `/path/to/bottlerocket-repo/variants`.
