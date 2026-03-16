# dotfiles

Shell, editor, and tool configs for macOS.

## Files

| File | Purpose |
|---|---|
| `.zshrc` | Zsh interactive shell config (aliases, PATH, plugins, tools) |
| `.zprofile` | Zsh login shell config (pipx, OrbStack) |
| `.gitconfig` | Global git identity with per-directory override for personal repos |
| `.vimrc` | Vim config (Pathogen, NERDTree, EasyMotion, Airline, fzf) |
| `.bash_profile` | Bash config (kept for reference, macOS uses zsh) |
| `.zsh_secrets.template` | Template for `~/.zsh_secrets` — copy and fill in API keys |
| `Brewfile` | Homebrew packages — install with `brew bundle` |

## Setup

```sh
# Clone
git clone https://github.com/chadleeshaw/dotfiles ~/src/chadleeshaw/dotfiles

# Symlink dotfiles
cd ~/src/chadleeshaw/dotfiles
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.zprofile ~/.zprofile
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.vimrc ~/.vimrc

# Set up secrets file (not tracked in git)
cp .zsh_secrets.template ~/.zsh_secrets
chmod 600 ~/.zsh_secrets
# Edit ~/.zsh_secrets and fill in your API keys

# Install Homebrew packages
brew bundle --file=Brewfile
```
