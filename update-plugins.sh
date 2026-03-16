#!/usr/bin/env bash
# Update vim (Pathogen) and nvim (Packer) plugins

set -e

echo "==> Updating vim plugins (Pathogen)..."
for i in ~/.vim/bundle/*; do
  echo "    $(basename $i)"
  git -C "$i" pull --quiet
done

echo ""
echo "==> Updating nvim plugins (Packer)..."
nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"

echo ""
echo "Done."
