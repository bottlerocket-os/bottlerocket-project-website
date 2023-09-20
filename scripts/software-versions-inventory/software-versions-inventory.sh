#!/bin/bash

shopt -s nullglob

bottlerocket_root=${1:?}
bottlerocket_release=$(grep "version =" $bottlerocket_root/Release.toml | cut -d "=" -f 2 | tr -d '"')

printf "%s\n" "---"
printf "title: \"%s\"\n" $bottlerocket_release
printf "type: \"docs\"\n"
printf "description: \"Package Versions in Bottlerocket Release %s\"\n" $bottlerocket_release
printf "packages:\n"
for d in $(find $bottlerocket_root/packages -mindepth 1 -maxdepth 1 -type d | sort)
do
    base=$(basename $d)
    rpmspec -q --qf "%{Version}:" $d/$base.spec  --define="_cross_os _" --nodebuginfo --quiet &> /dev/null

    if [ $? -eq 0 ]; then
        version=$(rpmspec -q --qf "%{Version}:" $d/$base.spec  --define="_cross_os _" --nodebuginfo)

        printf "%2s" " "
        printf "%s\r\n" "- package: $base"
        printf "%4s" " "
        printf "%s" "version: "
        printf "%s\n" "$version" | cut -d":" -f1
        patches=( "$d"/*.patch )
        if [[ ${#patches[@]} -gt 0 ]]; then
            printf "%4s" " "
            printf "%s\n" "patches:"
            for patch in "${patches[@]}"
            do
                patch_file=$(basename $patch)
                printf "%6s" " "
                printf "%s\n" "- \"$patch_file\""
            done
        fi
    fi
done
printf "%s\n" "---"
printf "\n"
printf "{{< packages-table >}}\n"
