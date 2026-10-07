#!/bin/bash
# Vendor upstream sing-box and apply the wyx2685 dynamic-user patch port.
# Usage: ./third_party/vendor-singbox.sh
# Result: third_party/sing-box/ ready for `replace github.com/sagernet/sing-box => ./third_party/sing-box`
set -euo pipefail

VERSION="v1.14.2"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="$SCRIPT_DIR/sing-box"
PATCH="$SCRIPT_DIR/patches/sing-box-v1.14.2-wyx2685-port.patch"
TARBALL_URL="https://github.com/SagerNet/sing-box/archive/refs/tags/${VERSION}.tar.gz"

if [[ -d "$TARGET" ]]; then
  echo "third_party/sing-box already exists, removing..."
  rm -rf "$TARGET"
fi

echo "Downloading sing-box ${VERSION}..."
TMPDIR_WORK="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_WORK"' EXIT
curl -fsSL "$TARBALL_URL" -o "$TMPDIR_WORK/sing-box.tar.gz"

echo "Extracting..."
tar xzf "$TMPDIR_WORK/sing-box.tar.gz" -C "$TMPDIR_WORK"
mv "$TMPDIR_WORK/sing-box-${VERSION#v}" "$TARGET"

echo "Applying wyx2685 dynamic-user patch..."
cd "$TARGET"
patch -p1 --no-backup-if-mismatch -i "$PATCH"

echo "Done: $TARGET"
