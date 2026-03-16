# dotfiles

Shell, editor, and tool configs for macOS.

## Files

| File | Purpose |
|---|---|
| `.zshrc` | Zsh interactive shell config (aliases, PATH, plugins, tools) |
| `.zprofile` | Zsh login shell config (pipx, OrbStack) |
| `.bash_profile` | Bash config (kept for reference, macOS uses zsh) |
| `.gitconfig` | Global git identity with per-directory override for personal repos |
| `.tmux.conf` | Tmux config |
| `.vimrc` | Vim config (Pathogen, NERDTree, EasyMotion, Airline, fzf) |
| `.zsh_secrets.template` | Template for `~/.zsh_secrets` — copy and fill in API keys |
| `.config/starship/starship.toml` | Starship prompt config |
| `.config/nvim/` | Neovim config (init.lua) |
| `.config/ghostty/config` | Ghostty terminal config |
| `.config/git/ignore` | Global gitignore |
| `Brewfile` | Homebrew packages — install with `brew bundle` |

## Setup

```sh
# Clone
git clone https://github.com/chadleeshaw/dotfiles ~/src/chadleeshaw/dotfiles
cd ~/src/chadleeshaw/dotfiles

# Symlink dotfiles
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.zprofile ~/.zprofile
ln -sf $(pwd)/.bash_profile ~/.bash_profile
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.tmux.conf ~/.tmux.conf
ln -sf $(pwd)/.vimrc ~/.vimrc

# Symlink .config files
ln -sf $(pwd)/.config/starship/starship.toml ~/.config/starship/starship.toml
ln -sf $(pwd)/.config/ghostty/config ~/.config/ghostty/config
ln -sf $(pwd)/.config/git/ignore ~/.config/git/ignore
ln -sf $(pwd)/.config/nvim ~/.config/nvim

# Set up secrets file (not tracked in git)
cp .zsh_secrets.template ~/.zsh_secrets
chmod 600 ~/.zsh_secrets
# Edit ~/.zsh_secrets and fill in your API keys

# Install Homebrew packages
brew bundle --file=Brewfile
```
