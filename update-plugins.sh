#!/usr/bin/env bash
# Update nvim plugins via lazy.nvim and sync dotfiles to origin

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

echo "==> Updating nvim plugins (lazy.nvim)..."
nvim --headless -c "lua require('lazy').sync()" -c "qa" 2>&1

echo ""
echo "==> Committing updated lazy-lock.json..."
if git -C "$SCRIPT_DIR" diff --quiet .config/nvim/lazy-lock.json; then
	echo "    No plugin version changes."
else
	git -C "$SCRIPT_DIR" add .config/nvim/lazy-lock.json
	git -C "$SCRIPT_DIR" commit -m "chore: update lazy-lock.json"
	echo "    Committed."
fi

echo ""
echo "==> Pushing dotfiles to origin..."
git -C "$SCRIPT_DIR" push

echo ""
echo "Done."
