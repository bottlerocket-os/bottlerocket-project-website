# Script: Software Versions Inventory

## Prerequisites

### `cargo`

Install `cargo` by installing the Rust toolchain via [rustup](https://rustup.rs).

### `make`

If you do not have it installed, install `make` on your system.
On fedora, run `sudo dnf install make`.

### `rpmspec`

On fedora, run `sudo dnf install rpm-build` to install the `rpmspec` command, which is used in the software versions inventory script.

### `bottlerocket-license-tool`

1. Clone the [Bottlerocket SDK repository](https://github.com/bottlerocket-os/bottlerocket-sdk)
2. `cd` into the directory where you cloned the SDK
3. Install the Bottlerocket license tool with `cargo install bottlerocket-license-tool --path ./license-tool/`

### Fetching licenses

1. Place a file named `Licenses.toml` in the root of your Bottlerocket OS repository with the following contents:

```toml
[nvidia]
spdx-id = "LicensesRef-NVIDIA-Customer-Use"
licenses = [
  { path = "LICENSE", license-url = "https://www.nvidia.com/en-us/drivers/nvidia-license/" }
]
```

2. Run `cargo make -e BUILDSYS_UPSTREAM_LICENSE_FETCH=true fetch-licenses` in the root of your Bottlerocket OS repository.

### Placing `Licenses.toml` in the expected location for `bottlerocket-license-tool`

1. Make the expected directory for `bottlerocket-license-tool` to find `Licenses.toml`:

```bash
mkdir -p ~/rpmbuild/BUILD/
```

2. Copy `Licenses.toml` to `~/rpmbuild/BUILD/`.

## Running the script

1. Run `./software-versions-inventory.sh PATH_TO_BOTTLEROCKET_OS_REPO > packages.markdown`, where `PATH_TO_BOTTLEROCKET_OS_REPO` is the path to the Bottlerocket OS repository from which you want to extract package versions.

## Script output

The output of the script is a markdown Hugo page containing YAML [front matter](https://gohugo.io/content-management/front-matter/) listing packages and their versions, usable in the Bottlerocket project website.
The content of the page is a table generated from the `packages` parameter in the YAML front matter.
