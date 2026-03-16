#!/usr/bin/env bash
# Update vim (Pathogen) and nvim (Packer) plugins


echo "==> Updating vim plugins (Pathogen)..."
for i in ~/.vim/bundle/*; do
  if [ ! -d "$i/.git" ]; then
    echo "    $(basename $i) — skipping (not a git repo)"
    continue
  fi
  echo "    $(basename $i)"
  git -C "$i" pull --quiet
done

echo ""
echo "==> Updating nvim plugins (Packer)..."
nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"

echo ""
echo "Done."
