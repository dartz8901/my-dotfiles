#!/usr/bin/env bash

DEFAULT=/etc/skel/.bashrc
PATCH=~/dotfiles/bashrc.patch
TARGET=~/.bashrc

DIFF_OUTPUT=$(diff "$TARGET" "$DEFAULT")

if [ $? -eq 1 ]; then
  echo "[-] Your \`.bashrc\` is already modified. This script was made to be used with a pure \`.bashrc\` only."
  echo "[-] Following is the difference:"
  echo ""
  echo "$DIFF_OUTPUT"
  echo ""
  echo "[-] Aborting..."
  exit 1
fi

echo "[*] Checking if patch can be applied on \`$TARGET\`..."

if patch --dry-run "$TARGET" "$PATCH" > /dev/null 2>&1; then
  echo "[*] OK. Patch can be applied. Applying now..."
  patch "$TARGET" "$PATCH"
else
  echo "[-] Could not apply patch (the difference is likely to high)."
  echo "[-] Aborting..."
  exit 1
fi

exit 0
