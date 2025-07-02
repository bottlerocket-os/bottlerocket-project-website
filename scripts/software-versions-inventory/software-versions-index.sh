#!/bin/bash

bottlerocket_release=$1

printf "+++\n"
printf "title=\"%s Package Versions\"\n" "$bottlerocket_release"
printf "type=\"docs\"\n"
printf "description=\"Versions of packages included in the %s release of Bottlerocket\"\n" "$bottlerocket_release"
printf "+++\n"
printf "\n"
