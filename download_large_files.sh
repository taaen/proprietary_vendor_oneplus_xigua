#!/bin/bash
# Download large vendor files from GitHub Releases
# Usage: bash download_large_files.sh [RELEASE_TAG]

RELEASE_TAG=${1:-"vendor-blobs-v1"}
RELEASE_URL="https://github.com/taaen/proprietary_vendor_oneplus_xigua/releases/download/${RELEASE_TAG}/vendor_xigua_large_files.tar.gz"

echo "Downloading large vendor files..."
curl -L -o vendor_xigua_large_files.tar.gz "$RELEASE_URL" || {
  echo "ERROR: Download failed. Download manually from:"
  echo "  https://github.com/taaen/proprietary_vendor_oneplus_xigua/releases"
  exit 1
}

echo "Extracting..."
tar xzf vendor_xigua_large_files.tar.gz
rm vendor_xigua_large_files.tar.gz
echo "Done."
