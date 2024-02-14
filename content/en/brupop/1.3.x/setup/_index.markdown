+++
type = "docs"
title = "Setup"
weight = 5
description = "Steps to use and configure Brupop on your Bottlerocket nodes"
+++

Setting up Brupop for the first time has three major steps:

- Installing the prerequisite, `cert-manager` on your cluster,
- Installing Brupop itself,
- Labeling the nodes you want to update with Brupop.

Many clusters require nothing more than the three above steps, but familiarize yourself with the additional configuration options before installing as you may need to tweak the configuration for your particular needs.
