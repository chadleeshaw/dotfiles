#!/usr/bin/env bash
# Update vim (Pathogen) and nvim (Packer) plugins

# Use gtimeout (coreutils) if available, otherwise fall back to plain git pull
if command -v gtimeout &>/dev/null; then
  GIT_PULL() { gtimeout 10s git -C "$1" pull --quiet; }
elif command -v timeout &>/dev/null; then
  GIT_PULL() { timeout 10s git -C "$1" pull --quiet; }
else
  GIT_PULL() { git -C "$1" pull --quiet; }
fi

echo "==> Updating vim plugins (Pathogen)..."
for i in ~/.vim/bundle/*; do
  if [ ! -d "$i/.git" ]; then
    echo "    $(basename $i) — skipping (not a git repo)"
    continue
  fi
  echo "    $(basename $i)"
  if ! GIT_PULL "$i"; then
    echo "    $(basename $i) — timed out or failed, skipping"
  fi
done

echo ""
echo "==> Updating nvim plugins (Packer)..."
nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"

echo ""
echo "Done."
