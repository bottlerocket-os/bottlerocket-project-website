#!/bin/bash

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

#######################################
# Print log messages with timestamp and level
# Arguments:
#   Level (INFO, WARN, ERROR)
#   Message to log
#######################################
log() {
    local level="${1:-INFO}"
    shift
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$level] $*" >&2
}

log_info() {
    log "INFO" "$@"
}

log_error() {
    log "ERROR" "$@"
}

#######################################
# Display help message
#######################################
show_help() {
    cat <<EOF
Usage: $(basename "$0") -b <bottlerocket-version>

Copy files from previous Bottlerocket version and generate new content.
Core kit and kernel kit versions are automatically extracted from the
Twoliter.toml file in the Bottlerocket repository.

Options:
    -b    Bottlerocket version number in X.Y.Z format
    -h    Show this help message

Example:
    $(basename "$0") -b 1.40.0
EOF
}

#######################################
# Parse command line arguments
#######################################
parse_args() {
    # Parse command line arguments
    while getopts "b:h" opt; do
        case ${opt} in
        b)
            NEW_BOTTLEROCKET_VERSION=$OPTARG
            ;;
        h)
            show_help
            exit 0
            ;;
        \?)
            show_help
            exit 1
            ;;
        esac
    done

    # Check if required argument is provided
    if [ -z "${NEW_BOTTLEROCKET_VERSION:-}" ]; then
        log_error "Bottlerocket version argument is required"
        show_help
        exit 1
    fi
}

#######################################
# Validate version format
# Arguments:
#   Version string
# Returns:
#   0 if valid, 1 if invalid
#######################################
validate_version() {
    local version=$1
    if ! [[ "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        log_error "Invalid version format for ${version}. Expected: X.Y.Z"
        return 1
    fi
    return 0
}

#######################################
# Extract and validate semantic version components
#######################################
parse_version() {
    MAJOR=$(echo "${NEW_BOTTLEROCKET_VERSION}" | cut -d'.' -f1)
    MINOR=$(echo "${NEW_BOTTLEROCKET_VERSION}" | cut -d'.' -f2)
    PATCH=$(echo "${NEW_BOTTLEROCKET_VERSION}" | cut -d'.' -f3)

    readonly MAJOR
    readonly MINOR
    readonly PATCH

    IS_PATCH_UPDATE=1

    if [ "${MINOR}" -eq 0 ]; then
        log_error "Invalid version format. Minor version cannot be 0."
        exit 1
    fi

    if [ "${PATCH}" -ne 0 ]; then
        log_info "This change is a patch update and not a minor version bump"
        IS_PATCH_UPDATE=0
    fi

    readonly PREV_MINOR=$((MINOR - 1))
    readonly MAJOR_MINOR_X="${MAJOR}.${MINOR}.x"
    readonly PREV_MAJOR_MINOR_X="${MAJOR}.${PREV_MINOR}.x"

    log_info "Parsed version: ${NEW_BOTTLEROCKET_VERSION} (Major: ${MAJOR}, Minor: ${MINOR}, Patch: ${PATCH})"
}

#######################################
# Clone a git repository and checkout specific version
# Arguments:
#   Repository URL
#   Target directory
#   Version to checkout
#######################################
git_clone_version() {
    local repo=$1
    local dir=$2
    local version=$3

    log_info "Cloning ${repo} to ${dir}"
    git clone "${repo}" "${dir}" &>/dev/null

    log_info "Checking out version ${version}"
    (cd "${dir}" && git checkout "tags/v${version}" &>/dev/null)

    log_info "Successfully checked out version ${version}"
}

#######################################
# Extract kit version from Twoliter.toml
# Arguments:
#   Kit name (e.g., "bottlerocket-core-kit")
#   Path to Twoliter.toml
# Outputs:
#   Version string
#######################################
extract_kit_version() {
    local kit_name=$1
    local toml_file=$2
    local version

    version=$(awk -v kit="$kit_name" '
        /^\[\[kit\]\]/ { in_kit=1; name=""; ver="" ; next }
        in_kit && /^name[[:space:]]*=/ { gsub(/.*=[[:space:]]*"|"/, ""); name=$0 }
        in_kit && /^version[[:space:]]*=/ { gsub(/.*=[[:space:]]*"|"/, ""); ver=$0 }
        in_kit && name != "" && ver != "" {
            if (name == kit) { print ver; exit }
            in_kit=0
        }
    ' "$toml_file")

    if [ -z "$version" ]; then
        log_error "Could not extract version for ${kit_name} from ${toml_file}"
        exit 1
    fi
    echo "$version"
}

#######################################
# Setup temporary directories and clone repositories
#######################################
setup_repositories() {
    TEMP_DIR=$(mktemp -d)
    readonly TEMP_DIR
    log_info "Created temporary directory: ${TEMP_DIR}"

    # Repository URLs
    readonly BOTTLEROCKET_REPO_URL="https://github.com/bottlerocket-os/bottlerocket.git"
    readonly BOTTLEROCKET_CORE_KIT_REPO_URL="https://github.com/bottlerocket-os/bottlerocket-core-kit.git"
    readonly BOTTLEROCKET_KERNEL_KIT_REPO_URL="https://github.com/bottlerocket-os/bottlerocket-kernel-kit.git"

    # Clone Bottlerocket repository first to extract kit versions
    readonly BOTTLEROCKET_REPO_DIR="${TEMP_DIR}/bottlerocket"
    mkdir "${BOTTLEROCKET_REPO_DIR}"
    log_info "Setting up Bottlerocket repository"
    git_clone_version "${BOTTLEROCKET_REPO_URL}" \
        "${BOTTLEROCKET_REPO_DIR}" \
        "${NEW_BOTTLEROCKET_VERSION}"

    # Extract kit versions from Twoliter.toml
    local twoliter_toml="${BOTTLEROCKET_REPO_DIR}/Twoliter.toml"
    if [ ! -f "${twoliter_toml}" ]; then
        log_error "Twoliter.toml not found in Bottlerocket repository"
        exit 1
    fi

    BOTTLEROCKET_CORE_KIT_VERSION=$(extract_kit_version "bottlerocket-core-kit" "${twoliter_toml}")
    BOTTLEROCKET_KERNEL_KIT_VERSION=$(extract_kit_version "bottlerocket-kernel-kit" "${twoliter_toml}")
    log_info "Extracted core-kit version: ${BOTTLEROCKET_CORE_KIT_VERSION}"
    log_info "Extracted kernel-kit version: ${BOTTLEROCKET_KERNEL_KIT_VERSION}"

    # Clone Core Kit repository
    readonly BOTTLEROCKET_CORE_KIT_REPO_DIR="${TEMP_DIR}/bottlerocket-core-kit"
    mkdir "${BOTTLEROCKET_CORE_KIT_REPO_DIR}"
    log_info "Setting up Core Kit repository"
    git_clone_version "${BOTTLEROCKET_CORE_KIT_REPO_URL}" \
        "${BOTTLEROCKET_CORE_KIT_REPO_DIR}" \
        "${BOTTLEROCKET_CORE_KIT_VERSION}"

    # Clone Kernel Kit repository
    readonly BOTTLEROCKET_KERNEL_KIT_REPO_DIR="${TEMP_DIR}/bottlerocket-kernel-kit"
    mkdir "${BOTTLEROCKET_KERNEL_KIT_REPO_DIR}"
    log_info "Setting up Kernel Kit repository"
    git_clone_version "${BOTTLEROCKET_KERNEL_KIT_REPO_URL}" \
        "${BOTTLEROCKET_KERNEL_KIT_REPO_DIR}" \
        "${BOTTLEROCKET_KERNEL_KIT_VERSION}"

    log_info "All repositories setup completed"
}

#######################################
# Clean up temporary files
#######################################
cleanup() {
    log_info "Cleaning up temporary files"
    if [ -d "${TEMP_DIR:-}" ]; then
        rm -rf "${TEMP_DIR}" || log_error "Cleanup failed. Manually delete ${TEMP_DIR}"
    fi
}

#######################################
# Copy content from previous version
#######################################
copy_content() {
    log_info "Copying content from ${PREV_MAJOR_MINOR_X} to ${MAJOR_MINOR_X}"

    mkdir "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}"

    # Copy directories
    log_info "Copying content directory"
    cp -R \
        "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${PREV_MAJOR_MINOR_X}/"* \
        "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}/"

    # Clean up old content
    log_info "Removing outdated content"
    rm -rf "${BOTTLEROCKET_WEBSITE_REPO_DIR}"/content/en/os/"${MAJOR_MINOR_X}"/version-information/packages/"${MAJOR}".*
    rm -rf "${BOTTLEROCKET_WEBSITE_REPO_DIR}"/content/en/os/"${MAJOR_MINOR_X}"/version-information/gpu-drivers/"${MAJOR}".*

    log_info "Content copying completed"
}

#######################################
# Update version labels
#######################################
update_version_labels() {
    # Function to perform sed operation with proper syntax for both Linux and macOS
    perform_sed() {
        local pattern=$1
        local file=$2

        if [ "$(uname)" == "Darwin" ]; then
            # macOS requires an empty string after -i for in-place editing
            sed -i '' "${pattern}" "${file}"
        else
            # Linux version of sed
            sed -i "${pattern}" "${file}"
        fi
    }

    # Update version labels
    perform_sed "s/ (Current)//g" \
        "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${PREV_MAJOR_MINOR_X}/_index.markdown"

    perform_sed "s/title=\"${PREV_MAJOR_MINOR_X} (Current)\"/title=\"${MAJOR_MINOR_X} (Current)\"/g" \
        "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}/_index.markdown"

}

#######################################
# Update the [os] version in data/versions/current.toml
# Only keys inside the [os] table are rewritten so the brupop and
# ecs-updater versions are left untouched.
#######################################
update_current_toml() {
    local toml_file="${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/versions/current.toml"
    local tmp_file="${toml_file}.tmp"

    log_info "Updating [os] version in current.toml to ${NEW_BOTTLEROCKET_VERSION}"

    awk -v major="${MAJOR}" -v minor="${MINOR}" -v patch="${PATCH}" '
        /^[[:space:]]*\[/ { in_os = ($0 ~ /^[[:space:]]*\[os\][[:space:]]*$/) }
        in_os && /^[[:space:]]*major[[:space:]]*=/ { sub(/=.*/, "= " major) }
        in_os && /^[[:space:]]*minor[[:space:]]*=/ { sub(/=.*/, "= " minor) }
        in_os && /^[[:space:]]*patch[[:space:]]*=/ { sub(/=.*/, "= " patch) }
        in_os && /^[[:space:]]*foldable_check_id[[:space:]]*=/ {
            sub(/=.*/, "= \"#m-enos" major minor "x-check\"")
        }
        { print }
    ' "${toml_file}" >"${tmp_file}"

    mv "${tmp_file}" "${toml_file}"
}

#######################################
# Generate new content
#######################################
generate_new_content() {
    # Generate package version data
    log_info "Generating package version data"
    local package_dir="${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}/version-information/packages/${NEW_BOTTLEROCKET_VERSION}"
    mkdir -p "${package_dir}"

    # Generate top level _index.md for packages
    log_info "Generating _index.md for packages/"
    "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/software-versions-inventory/software-versions-index.sh" \
        "${NEW_BOTTLEROCKET_VERSION}" > \
        "${package_dir}/_index.markdown"

    log_info "Generating core-kit packages"
    "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/software-versions-inventory/software-versions-inventory.sh" \
        "${NEW_BOTTLEROCKET_VERSION}" "${BOTTLEROCKET_CORE_KIT_REPO_DIR}" > \
        "${package_dir}/core-kit-packages.markdown"

    log_info "Generating kernel-kit packages"
    "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/software-versions-inventory/software-versions-inventory.sh" \
        "${NEW_BOTTLEROCKET_VERSION}" "${BOTTLEROCKET_KERNEL_KIT_REPO_DIR}" > \
        "${package_dir}/kernel-kit-packages.markdown"

    # Generate NVIDIA information
    log_info "Generating NVIDIA version information"
    local nvidia_dir="${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/nvidia/${NEW_BOTTLEROCKET_VERSION}"
    mkdir -p "${nvidia_dir}"

    (cd "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/nvidia-driver-versions" &&
        ./get_cargos.sh "${BOTTLEROCKET_KERNEL_KIT_REPO_DIR}" \
            "${nvidia_dir}/")

    (cd "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/nvidia-driver-versions" &&
        ./create_markdown.sh \
            "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}/version-information/gpu-drivers" \
            "${NEW_BOTTLEROCKET_VERSION}")

    # Generate Kernel Version information
    log_info "Generating Kernel Version information"
    local variants_dir="${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/variants/${MAJOR_MINOR_X}"
    mkdir -p "${variants_dir}"

    (cd "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/variant-kernel" &&
        ./get_cargos.sh "${BOTTLEROCKET_REPO_DIR}/variants" "${variants_dir}/")

    log_info "Content generation completed"
}

main() {
    log_info "Starting Bottlerocket website update process"
    parse_args "$@"

    # Path to website repository
    BOTTLEROCKET_WEBSITE_REPO_DIR=$(git rev-parse --show-toplevel)
    readonly BOTTLEROCKET_WEBSITE_REPO_DIR
    log_info "Website repository directory: ${BOTTLEROCKET_WEBSITE_REPO_DIR}"

    # Validate bottlerocket version
    validate_version "${NEW_BOTTLEROCKET_VERSION}" || exit 1

    parse_version
    setup_repositories

    # Validate extracted kit versions
    validate_version "${BOTTLEROCKET_CORE_KIT_VERSION}" || exit 1
    validate_version "${BOTTLEROCKET_KERNEL_KIT_VERSION}" || exit 1

    if [[ "${IS_PATCH_UPDATE}" -ne 0 ]]; then
        copy_content
        update_version_labels
    fi

    # current.toml always tracks the newly released version, whether the
    # release is a minor bump or a patch on the current minor version.
    update_current_toml

    generate_new_content

    cleanup
    log_info "Bottlerocket website update completed successfully"
}

# Set up cleanup trap
trap cleanup EXIT

# Call main with all script arguments
main "$@"
