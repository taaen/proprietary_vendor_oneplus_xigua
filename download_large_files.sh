#!/bin/bash
# Download large vendor files from GitHub Releases (skips if already present)

RELEASE_TAG=${1:-"vendor-blobs-v1"}

# 检查是否所有大文件都已存在
NEED_DOWNLOAD=0
MISSING=""
FILES=(
  "radio/modem.img"
  "proprietary/odm/lib64/libCipParameter0.so"
  "proprietary/odm/lib64/libCipParameter2.so"
  "proprietary/odm/lib64/libCipParameter3.so"
  "proprietary/odm/lib64/libarcsoft_turbo_hdr_raw.so"
)

for f in "${FILES[@]}"; do
  if [ ! -f "$f" ]; then
    NEED_DOWNLOAD=1
    MISSING="$MISSING  $f\n"
  fi
done

if [ "$NEED_DOWNLOAD" -eq 0 ]; then
  echo "All large vendor files already present, skipping download."
  exit 0
fi

echo "Missing files:"
echo -e "$MISSING"
echo "Downloading from GitHub Releases (tag: $RELEASE_TAG)..."

RELEASE_URL="https://github.com/taaen/proprietary_vendor_oneplus_xigua/releases/download/${RELEASE_TAG}/vendor_xigua_large_files.tar.gz"

curl -L -o vendor_xigua_large_files.tar.gz "$RELEASE_URL" || {
  echo "ERROR: Download failed. Get manually from:"
  echo "  https://github.com/taaen/proprietary_vendor_oneplus_xigua/releases"
  exit 1
}

echo "Extracting..."
tar xzf vendor_xigua_large_files.tar.gz
rm vendor_xigua_large_files.tar.gz
echo "Done."