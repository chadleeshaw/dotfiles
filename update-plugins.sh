#!/usr/bin/env zsh
# Update nvim plugins via lazy.nvim and sync dotfiles to origin

echo "==> Updating nvim plugins (lazy.nvim)..."
nvim --headless -c "lua require('lazy').sync()" -c "qa" 2>&1

echo ""
echo "==> Committing updated lazy-lock.json..."
if git -C "${0:A:h}" diff --quiet .config/nvim/lazy-lock.json; then
  echo "    No plugin version changes."
else
  git -C "${0:A:h}" add .config/nvim/lazy-lock.json
  git -C "${0:A:h}" commit -m "chore: update lazy-lock.json"
  echo "    Committed."
fi

echo ""
echo "==> Pushing dotfiles to origin..."
git -C "${0:A:h}" push

echo ""
echo "Done."
