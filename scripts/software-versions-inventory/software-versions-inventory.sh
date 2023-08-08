#!/bin/bash

bottlerocket_release=$(grep "version =" $1/Release.toml | cut -d "=" -f 2 | tr -d '"')
printf "%s\n" "---"
printf "title: \"%s\"\n" $bottlerocket_release
printf "type: \"docs\"\n"
printf "description: \"Package Versions in Bottlerocket Release %s\"\n" $bottlerocket_release
printf "packages:\n"
for d in $(find $1/packages -maxdepth 1 -type d | sort)
do
    if [ $d != $1/packages ]; then
        base=$(basename $d)
        rpmspec -q --qf "%{Version}:" $d/$base.spec  --define="_cross_os _" --nodebuginfo --quiet &> /dev/null

        if [ $? -eq 0 ]; then
            version=$(rpmspec -q --qf "%{Version}:" $d/$base.spec  --define="_cross_os _" --nodebuginfo)

            printf "%2s" " "
            printf "%s\r\n" "- package: $base"
            printf "%4s" " " 
            printf "%s" "version: "
            printf "%s\n" "$version" | cut -d":" -f1
            patch_count=`find $d -type f -name "*.patch" | wc -l`
            if [ $patch_count -gt 0 ]; then
                patches=`find $d -type f -name "*.patch"`
                printf "%4s" " "
                printf "%s\n" "patches:"
                for patch in $patches
                do
                    patch_file=$(basename $patch)
                    printf "%6s" " " 
                    printf "%s\n" "- \"$patch_file\""
                done
            fi
        fi
    fi
done
printf "%s\n" "---"
printf "\n"
printf "{{< packages-table >}}\n"
