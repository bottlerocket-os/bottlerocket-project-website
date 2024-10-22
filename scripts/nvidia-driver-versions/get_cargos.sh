#!/bin/bash

# find $1/* -name "Cargo.toml" -exec bash create_data_file_from_cargo.sh {} $2  \;
find $1/packages/kmod-*-nvidia -name "Cargo.toml" -exec bash create_data_file_from_cargo.sh {} $2  \;
