#!/bin/bash

FNAME="$(echo $1 | awk -F/ '{print $(NF-1)}')"
EXTRACTED="# Extracted from https://github.com/bottlerocket-os/bottlerocket-core-kit/tree/develop/packages/$FNAME/Cargo.toml"
echo $EXTRACTED > $2$FNAME.toml
cat $1 >> $2$FNAME.toml
