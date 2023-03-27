#!/bin/bash

FNAME="$(echo $1 | awk -F/ '{print $(NF-1)}')"
EXTRACTED="# Extracted from https://github.com/bottlerocket-os/bottlerocket/variants/$FNAME/Cargo.toml"
if [ "$FNAME" != "variants" ]
then
	echo $EXTRACTED > $2$FNAME.toml
	cat $1 >> $2$FNAME.toml
fi