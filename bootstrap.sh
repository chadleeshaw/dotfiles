#!/usr/bin/env zsh
# Bootstrap a new macOS machine from dotfiles
# https://github.com/chadleeshaw/dotfiles

set -e

DOTFILES="$HOME/src/chadleeshaw/dotfiles"

echo ""
echo "======================================"
echo " macOS Bootstrap"
echo "======================================"
echo ""

# -------------------------------------------------------
# 1. Xcode CLI tools
# -------------------------------------------------------
echo "==> Checking for Xcode CLI tools..."
if ! xcode-select -p &>/dev/null; then
  echo "    Installing Xcode CLI tools..."
  xcode-select --install
  echo "    Follow the prompt, then re-run this script."
  exit 1
fi
echo "    Xcode CLI tools found."

# -------------------------------------------------------
# 2. SSH keys — required to clone from GitHub
# -------------------------------------------------------
echo "==> Checking for SSH keys..."
if [ ! -f ~/.ssh/id_ed25519 ] && [ ! -f ~/.ssh/id_rsa ]; then
  echo ""
  echo "    No SSH key found. You need one to clone from GitHub."
  echo "    Run the following, then add the public key to GitHub:"
  echo ""
  echo "      ssh-keygen -t ed25519 -C \"your@email.com\""
  echo "      cat ~/.ssh/id_ed25519.pub"
  echo "      https://github.com/settings/keys"
  echo ""
  echo "    Re-run this script once your SSH key is set up."
  exit 1
fi
echo "    SSH key found."

# -------------------------------------------------------
# 3. Homebrew
# -------------------------------------------------------
echo ""
echo "==> Checking for Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "    Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "    Homebrew already installed."
fi

# -------------------------------------------------------
# 4. Clone dotfiles
# -------------------------------------------------------
echo ""
echo "==> Cloning dotfiles..."
if [ -d "$DOTFILES" ]; then
  echo "    Already cloned, pulling latest..."
  git -C "$DOTFILES" pull --quiet
else
  mkdir -p "$HOME/src/chadleeshaw"
  git clone git@github.com:chadleeshaw/dotfiles.git "$DOTFILES"
fi

# -------------------------------------------------------
# 5. Symlink dotfiles
# -------------------------------------------------------
echo ""
echo "==> Symlinking dotfiles..."
ln -sf "$DOTFILES/.zshrc"       ~/.zshrc
ln -sf "$DOTFILES/.zprofile"    ~/.zprofile
ln -sf "$DOTFILES/.bash_profile" ~/.bash_profile
ln -sf "$DOTFILES/.gitconfig"   ~/.gitconfig
ln -sf "$DOTFILES/.gitconfig-chadleeshaw" ~/.gitconfig-chadleeshaw
ln -sf "$DOTFILES/.tmux.conf"   ~/.tmux.conf
echo "    Done."

echo ""
echo "==> Symlinking .config files..."
mkdir -p ~/.config/starship ~/.config/ghostty ~/.config/git
ln -sf "$DOTFILES/.config/starship/starship.toml" ~/.config/starship/starship.toml
ln -sf "$DOTFILES/.config/ghostty/config"         ~/.config/ghostty/config
ln -sf "$DOTFILES/.config/git/ignore"             ~/.config/git/ignore
rm -rf ~/.config/nvim
ln -sf "$DOTFILES/.config/nvim"                   ~/.config/nvim
echo "    Done."

# -------------------------------------------------------
# 6. Secrets file
# -------------------------------------------------------
echo ""
echo "==> Checking for ~/.zsh_secrets..."
if [ ! -f ~/.zsh_secrets ]; then
  cp "$DOTFILES/.zsh_secrets.template" ~/.zsh_secrets
  chmod 600 ~/.zsh_secrets
  echo "    Created ~/.zsh_secrets from template."
  echo "    !! Edit ~/.zsh_secrets and fill in your API keys before continuing."
else
  echo "    ~/.zsh_secrets already exists."
fi

# -------------------------------------------------------
# 7. Homebrew packages
# -------------------------------------------------------
echo ""
echo "==> Installing Homebrew packages..."
brew bundle --file="$DOTFILES/Brewfile"

# -------------------------------------------------------
# 8. Neovim plugins (Packer)
# -------------------------------------------------------
echo ""
echo "==> Bootstrapping Neovim plugins (Packer)..."
PACKER_PATH="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ ! -d "$PACKER_PATH" ]; then
  git clone --quiet --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_PATH"
  echo "    Packer installed."
fi
echo "    Running PackerSync (this may take a moment)..."
nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"
echo "    Done."

# -------------------------------------------------------
# Done
# -------------------------------------------------------
echo ""
echo "======================================"
echo " Bootstrap complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo "  1. Edit ~/.zsh_secrets with your API keys"
echo "  2. Start a new shell session: exec zsh"
echo ""
