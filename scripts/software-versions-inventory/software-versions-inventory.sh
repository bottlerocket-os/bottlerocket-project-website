#!/bin/bash

bottlerocket_release=$1
# Find kit name
kit_name=""
for file in "$2"/kits/*kit*; do
    if [ -f "$file" ] || [ -d "$file" ]; then
        kit_name=$(basename "$file" | cut -d "-" -f2)
        # Capitalize first letter
        first_char=$(echo "${kit_name:0:1}" | tr '[:lower:]' '[:upper:]')
        kit_name="${first_char}${kit_name:1}"
        break
    fi
done
kit_release=$(grep "release-version =" "$2"/Twoliter.toml | cut -d "=" -f 2 | tr -d '"' | tr -d " ")
printf "%s\n" "---"
printf "title: \"%s Kit packages %s\"\n" "$kit_name" "$kit_release"
printf "type: \"docs\"\n"
printf "description: \"%s Kit Package Versions in Bottlerocket Release %s\"\n" "$kit_name" "$bottlerocket_release"
printf "packages:\n"
for d in $(find "$2"/packages -maxdepth 1 -type d | sort); do
    if [ "$d" != "$2"/packages ]; then
        package_name=$(basename "$d")
        # rpmspec -q --qf "%{Version}:" "$d"/"$package_name".spec  --define="_cross_os _" --nodebuginfo --quiet &> /dev/null

        if version=$(rpmspec -q --qf "%{Version}:" "$d"/"$package_name".spec --define="_cross_os _" --nodebuginfo 2>/dev/null); then
            # version=$(rpmspec -q --qf "%{Version}:" "$d"/"$package_name".spec  --define="_cross_os _" --nodebuginfo)

            printf "%2s" " "
            printf "%s\r\n" "- package: $package_name"
            printf "%4s" " "
            printf "%s" "version: "
            printf "%s\n" "$version" | cut -d":" -f1
            patch_count=$(find "$d" -type f -name "*.patch" | wc -l)
            if [ "$patch_count" -gt 0 ]; then
                patches=$(find "$d" -type f -name "*.patch")
                printf "%4s" " "
                printf "%s\n" "patches:"
                for patch in $patches; do
                    patch_file=$(basename "$patch")
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
