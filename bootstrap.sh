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
# 1. SSH keys — required to clone from GitHub
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
# 2. Homebrew
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
# 3. Clone dotfiles
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
# 4. Symlink dotfiles
# -------------------------------------------------------
echo ""
echo "==> Symlinking dotfiles..."
ln -sf "$DOTFILES/.zshrc"       ~/.zshrc
ln -sf "$DOTFILES/.zprofile"    ~/.zprofile
ln -sf "$DOTFILES/.bash_profile" ~/.bash_profile
ln -sf "$DOTFILES/.gitconfig"   ~/.gitconfig
ln -sf "$DOTFILES/.gitconfig-chadleeshaw" ~/.gitconfig-chadleeshaw
ln -sf "$DOTFILES/.tmux.conf"   ~/.tmux.conf
ln -sf "$DOTFILES/.vimrc"       ~/.vimrc
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
# 5. Secrets file
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
# 6. Homebrew packages
# -------------------------------------------------------
echo ""
echo "==> Installing Homebrew packages..."
brew bundle --file="$DOTFILES/Brewfile"

# -------------------------------------------------------
# 7. Vim plugins (Pathogen)
# -------------------------------------------------------
echo ""
echo "==> Installing vim plugins (Pathogen)..."
mkdir -p ~/.vim/autoload ~/.vim/bundle
if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi
PLUGINS=(
  "https://github.com/ctrlpvim/ctrlp.vim"
  "https://github.com/tpope/vim-fugitive"
  "https://github.com/davidhalter/jedi-vim"
  "https://github.com/preservim/nerdtree"
  "https://github.com/Xuyuanp/nerdtree-git-plugin"
  "https://github.com/saltstack/salt-vim"
  "https://github.com/vim-airline/vim-airline"
  "https://github.com/tpope/vim-commentary"
  "https://github.com/easymotion/vim-easymotion"
  "https://github.com/jistr/vim-nerdtree-tabs"
  "https://github.com/tpope/vim-surround"
  "https://github.com/tpope/vim-system-copy"
  "https://github.com/stephpy/vim-yaml"
)
for repo in $PLUGINS; do
  name=$(basename $repo)
  if [ ! -d ~/.vim/bundle/$name ]; then
    git clone --quiet $repo ~/.vim/bundle/$name
    echo "    Installed $name"
  else
    echo "    $name already installed"
  fi
done

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
