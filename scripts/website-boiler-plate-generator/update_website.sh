#!/bin/bash

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

#######################################
# Print log messages with timestamp
# Arguments:
#   Message to log
#######################################
log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

#######################################
# Display help message
#######################################
show_help() {
  cat << EOF
Usage: $(basename "$0") <bottlerocket-version> <core-kit-version> <kernel-kit-version>

Copy files from previous Bottlerocket version and generate new content.

Arguments:
    bottlerocket-version   Version number in X.Y.Z format
    core-kit-version      Core kit version in X.Y.Z format
    kernel-kit-version    Kernel kit version in X.Y.Z format
EOF
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
    log "Invalid version format for ${version}. Expected: X.Y.Z"
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
  IS_PATCH_UPDATE=1
  if [ "${MINOR}" -eq 0 ]; then
    log "Invalid version format. Minor version cannot be 0."
    exit 1
  fi

  if [ "${PATCH}" -ne 0 ]; then
    log "This change is a patch update and not a minor version bump"
    IS_PATCH_UPDATE=0
  fi

  readonly PREV_MINOR=$((MINOR - 1))
  readonly MAJOR_MINOR_X="${MAJOR}.${MINOR}.x"
  readonly PREV_MAJOR_MINOR_X="${MAJOR}.${PREV_MINOR}.x"
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

    log "Cloning ${repo} to ${dir}"
    git clone "${repo}" "${dir}" &>/dev/null

    log "Checking out version ${version}"
    (cd "${dir}" && git checkout "tags/v${version}" &>/dev/null)
}

#######################################
# Setup temporary directories and clone repositories
#######################################
setup_repositories() {
  TEMP_DIR=$(mktemp -d)
  log "Created temporary directory: ${TEMP_DIR}"

  # Clone Bottlerocket repository
  BOTTLEROCKET_REPO_DIR=${TEMP_DIR}/bottlerocket
  mkdir "${BOTTLEROCKET_REPO_DIR}"
  git_clone_version "git@github.com:bottlerocket-os/bottlerocket.git" \
    "${BOTTLEROCKET_REPO_DIR}" \
    "${NEW_BOTTLEROCKET_VERSION}"

  # Clone Core Kit repository
  BOTTLEROCKET_CORE_KIT_REPO_DIR=${TEMP_DIR}/bottlerocket-core-kit
  mkdir "${BOTTLEROCKET_CORE_KIT_REPO_DIR}"
  git_clone_version "git@github.com:bottlerocket-os/bottlerocket-core-kit.git" \
    "${BOTTLEROCKET_CORE_KIT_REPO_DIR}" \
    "${BOTTLEROCKET_CORE_KIT_VERSION}"

  # Clone Kernel Kit repository
  BOTTLEROCKET_KERNEL_KIT_REPO_DIR=${TEMP_DIR}/bottlerocket-kernel-kit
  mkdir "${BOTTLEROCKET_KERNEL_KIT_REPO_DIR}"
  git_clone_version "git@github.com:bottlerocket-os/bottlerocket-kernel-kit.git" \
    "${BOTTLEROCKET_KERNEL_KIT_REPO_DIR}" \
    "${BOTTLEROCKET_KERNEL_KIT_VERSION}"
}

#######################################
# Clean up temporary files
#######################################
cleanup() {
  log "Cleaning up temporary files"
  if [ -d "${TEMP_DIR:-}" ]; then
    rm -rf "${TEMP_DIR}" || log "Warning: Cleanup failed. Manually delete ${TEMP_DIR}"
  fi
}

#######################################
# Copy content from previous version
#######################################
copy_content() {
  log "Copying content from ${PREV_MAJOR_MINOR_X} to ${MAJOR_MINOR_X}"

  mkdir "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}"
  
  # Copy directories
  cp -R \
    "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${PREV_MAJOR_MINOR_X}/" \
    "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}/"
  cp -R \
    "${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/settings/${PREV_MAJOR_MINOR_X}/" \
    "${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/settings/${MAJOR_MINOR_X}/"

  # Clean up old content
  log "Removing outdated content"
  rm -rf "${BOTTLEROCKET_WEBSITE_REPO_DIR}"/content/en/os/"${MAJOR_MINOR_X}"/version-information/packages/"${MAJOR}".*
  rm -rf "${BOTTLEROCKET_WEBSITE_REPO_DIR}"/content/en/os/"${MAJOR_MINOR_X}"/version-information/gpu-drivers/"${MAJOR}".*
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
  
  perform_sed "s/minor = ${PREV_MINOR}/minor = ${MINOR}/g" \
    "${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/versions/current.toml"
  
  perform_sed "s/m-enos${MAJOR}${PREV_MINOR}x-check/m-enos${MAJOR}${MINOR}x-check/g" \
    "${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/versions/current.toml"
}

#######################################
# Generate new content
#######################################
generate_new_content() {
  # Generate package version data
  log "Generating package version data"
  local package_dir="${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}/version-information/packages/${NEW_BOTTLEROCKET_VERSION}"
  mkdir -p "${package_dir}"

  # "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/software-versions-inventory/software-versions-inventory.sh" \
  #   "${NEW_BOTTLEROCKET_VERSION}" "${BOTTLEROCKET_CORE_KIT_REPO_DIR}" > \
  #   "${package_dir}/core-kit-packages.markdown"

  "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/software-versions-inventory/software-versions-inventory.sh" \
    "${NEW_BOTTLEROCKET_VERSION}" "${BOTTLEROCKET_KERNEL_KIT_REPO_DIR}" > \
    "${package_dir}/kernel-kit-packages.markdown"
  
  # Generate NVIDIA information
  log "Generating NVIDIA version information"
  # local nvidia_dir="${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/nvidia/${NEW_BOTTLEROCKET_VERSION}"
  # mkdir -p "${nvidia_dir}"

  # (cd "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/nvidia-driver-versions" && \
  #   ./get_cargos.sh "${BOTTLEROCKET_KERNEL_KIT_REPO_DIR}" \
  #    "${nvidia_dir}/")

  # (cd "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/nvidia-driver-versions" && \
  #   ./create_markdown.sh \
  #   "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}/version-information/gpu-drivers" \
  #   "${NEW_BOTTLEROCKET_VERSION}")

  # # Generate Kernel Version information
  # log "Generating Kernel Version information"
  # local variants_dir="${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/variants/${MAJOR_MINOR_X}"
  # mkdir -p "${variants_dir}"

  # (cd "${BOTTLEROCKET_WEBSITE_REPO_DIR}/scripts/variant-kernel" && \
  #   ./get_cargos.sh "${BOTTLEROCKET_REPO_DIR}/variants" "${variants_dir}/")
}

main (){
  # Path to website repository
  BOTTLEROCKET_WEBSITE_REPO_DIR=$(git rev-parse --show-toplevel)

  parse_version
  setup_repositories
  # if [[ IS_PATCH_UPDATE -ne 0 ]]; then
  #   copy_content
  #   update_version_labels
  # fi
  generate_new_content

  cleanup
}

# Script entry point
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    log "Error: Incorrect number of arguments"
    show_help
    exit 1
fi

# Set and validate input parameters
readonly NEW_BOTTLEROCKET_VERSION="${1}"
readonly BOTTLEROCKET_CORE_KIT_VERSION="${2}"
readonly BOTTLEROCKET_KERNEL_KIT_VERSION="${3}"

# Validate all versions
for version in "${NEW_BOTTLEROCKET_VERSION}" "${BOTTLEROCKET_CORE_KIT_VERSION}" "${BOTTLEROCKET_KERNEL_KIT_VERSION}"; do
    validate_version "${version}" || exit 1
done

# Set up cleanup trap
trap cleanup EXIT

main
