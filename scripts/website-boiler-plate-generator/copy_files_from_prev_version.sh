#!/bin/bash

# Path to website repository
BOTTLEROCKET_WEBSITE_REPO_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

VERSION="${1}"

# Check if the version format is valid (X.Y.Z)
if ! [[ "${VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid version format. Expected: X.Y.Z"
  exit 1
fi

MAJOR=$(echo "${VERSION}" | cut -d'.' -f1)
MINOR=$(echo "${VERSION}" | cut -d'.' -f2)
PATCH=$(echo "${VERSION}" | cut -d'.' -f3)

# Check if MINOR is 0, which is an invalid case
if [ "${MINOR}" -eq 0 ]; then
  echo "Invalid version format. Minor version cannot be 0."
  exit 1
fi

# Check if PATCH is not 0, which is an invalid case
if [ "${PATCH}" -ne 0 ]; then
  echo "Invalid version format. Patch version must be 0. This script is only meant to copy contents for new minor version."
  exit 1
fi

PREV_MINOR=$((MINOR - 1))
MAJOR_MINOR_X="${MAJOR}.${MINOR}.x"
PREV_MAJOR_MINOR_X="${MAJOR}.${PREV_MINOR}.x"

# Copy previous minor version content to the latest minor version
cp -R "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${PREV_MAJOR_MINOR_X}/" \
"${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}/"
cp -R "${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/settings/${PREV_MAJOR_MINOR_X}/" \
"${BOTTLEROCKET_WEBSITE_REPO_DIR}/data/settings/${MAJOR_MINOR_X}/"

# Remove invalid files and folders
rm -rf "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}/version-information/packages/${MAJOR}.*"
rm -rf "${BOTTLEROCKET_WEBSITE_REPO_DIR}/content/en/os/${MAJOR_MINOR_X}/version-information/gpu-drivers/${MAJOR}.*"
