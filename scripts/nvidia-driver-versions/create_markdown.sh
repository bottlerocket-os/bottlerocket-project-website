#!/bin/bash

mkdir $1/$2

cat << EOF > $1/$2/index.markdown
+++
title = "${2}"
description = "Drivers included in each GPU-enabled variant"
type = "docs"
+++

{{< nvidia-versions >}}
EOF