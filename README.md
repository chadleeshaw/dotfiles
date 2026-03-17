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
| `.config/nvim/` | Neovim config (Lazy.nvim, Dracula theme, LSP, nvim-lint) |
| `.config/ghostty/config` | Ghostty terminal config |
| `.config/git/ignore` | Global gitignore |
| `Brewfile` | Homebrew packages — install with `brew bundle` |
| `bootstrap.sh` | Full machine bootstrap script for a new macOS install |
| `update-plugins.sh` | Update Neovim plugins via lazy.nvim and commit lock file |

## Neovim

Configured with [Lazy.nvim](https://github.com/folke/lazy.nvim). Key plugins:

- **Theme** — [Dracula](https://github.com/Mofiqul/dracula.nvim)
- **LSP** — mason.nvim + nvim-lspconfig, diagnostics float on CursorHold
- **Linting** — [nvim-lint](https://github.com/mfussenegger/nvim-lint) (shellcheck for sh/bash, pylint for python)
- **Formatting** — none-ls (stylua, gofmt, shfmt, codespell), format on save
- **Completion** — nvim-cmp
- **Fuzzy find** — Telescope
- **File tree** — nvim-tree
- **Status bar** — lualine (Dracula theme)
- **Git** — gitsigns, diffview
- **Navigation** — harpoon, outline.nvim, which-key, trouble.nvim

## Shell

Notable `.zshrc` features:

- **yazi** — `y` function wrapper that `cd`s into the last directory on exit; `Ctrl+Y` binding
- **fzf** — file/directory preview via `eza` and `bat`
- **Starship** prompt
- Aliases for `eza`, `kubectl`/`kubecolor`, `incus`, Helm cache clear, and more

## Setup

For a new machine, run the bootstrap script:

```sh
git clone https://github.com/chadleeshaw/dotfiles ~/src/chadleeshaw/dotfiles
~/src/chadleeshaw/dotfiles/bootstrap.sh
```

The bootstrap script also clones [dot-opencode](https://github.com/chadleeshaw/dot-opencode) to `~/.agents` and runs its `setup.sh`.

Or manually symlink individual files:

```sh
cd ~/src/chadleeshaw/dotfiles

# Dotfiles
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.zprofile ~/.zprofile
ln -sf $(pwd)/.bash_profile ~/.bash_profile
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.tmux.conf ~/.tmux.conf

# .config files
ln -sf $(pwd)/.config/starship/starship.toml ~/.config/starship/starship.toml
ln -sf $(pwd)/.config/ghostty/config ~/.config/ghostty/config
ln -sf $(pwd)/.config/git/ignore ~/.config/git/ignore
ln -sf $(pwd)/.config/nvim ~/.config/nvim

# Secrets (not tracked in git)
cp .zsh_secrets.template ~/.zsh_secrets
chmod 600 ~/.zsh_secrets

# Homebrew packages
brew bundle --file=Brewfile
```
