export PATH="$HOME/.local/bin:$PATH"
export CLICOLOR=1
eval "$(/opt/homebrew/bin/brew shellenv)"
ulimit -n 2048

export EDITOR="nvim"
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export GOOS="darwin"
export GOARCH="arm64"
export GOBIN=$GOPATH/bin
export GEM_HOME=$HOME/.gem
export PATH=$PATH:$HOME/src/pops/salt-states/bin:${GOPATH}/bin:${GOROOT}/bin
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.agents/scripts:$PATH"
export JAVA_HOME=/opt/homebrew/opt/openjdk
export WARP_DISABLE_PROMPT_OVERRIDE=1
export CLAUDE_TEAMS_BACKENDS=opencode

# Plugins
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug 'wfxr/forgit'
zplug load
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview 'f={}; if [ -d \"\$f\" ]; then eza --icons --tree --level=2 --color=always \"\$f\"; else case \"\$f\" in *.pdf) pdftotext -l 10 \"\$f\" - 2>/dev/null | head -200;; *.docx|*.rtf|*.odt|*.epub) pandoc --to=plain \"\$f\" 2>/dev/null | head -200;; *.md|*.markdown) mdless \"\$f\" 2>/dev/null | head -200 || bat --color=always --style=numbers,changes --line-range=:200 \"\$f\";; *.json) jq --color-output . \"\$f\" 2>/dev/null | head -200 || bat --color=always --style=numbers,changes --line-range=:200 \"\$f\";; *.yaml|*.yml) yq --colors . \"\$f\" 2>/dev/null | head -200 || bat --color=always --style=numbers,changes --line-range=:200 \"\$f\";; *) bat --color=always --style=numbers,changes --line-range=:200 \"\$f\" 2>/dev/null || cat \"\$f\";; esac; fi' --preview-window='right:60%:wrap' --bind='ctrl-/:toggle-preview'"
[ -f ~/.zsh/.fzf.zsh ] && source ~/.zsh/.fzf.zsh
[ -f ~/.zsh/zsh-autosuggestions.zsh ] && source ~/.zsh/zsh-autosuggestions.zsh
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# Yazi - launch with Ctrl+Y, cd into directory on exit
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
bindkey -s '^y' 'y\n'

# Pi - launch with Ctrl+O (or pass current prompt)
function _pi_zsh_widget() {
  if [[ -z "$BUFFER" ]]; then
    BUFFER="pi"
  else
    BUFFER="pi ${(qq)BUFFER}"
  fi
  zle accept-line
}
zle -N _pi_zsh_widget
bindkey '^o' _pi_zsh_widget

# Aliases
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -la"
alias vi='nvim'
alias vim='nvim'
alias x='exit'
alias c='clear'
alias claude='claude --dangerously-skip-permissions'
alias huh='ps aux | grep '
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias renew='sudo ifconfig en6 down && sudo ifconfig en6 up'
alias k='kubecolor'
alias t='terraform'
alias m='mrmeseeks'
alias kx='kubectx'
alias kn='kubens'
alias sre='sre-tui'
alias code="open -a 'Visual Studio Code'"
alias ise='incus remote switch se'
alias isw='incus remote switch sw'
alias itp='incus remote switch tp'
alias gr="GOOS=darwin GOARCH=arm64 go run"
alias hcc="rm -rf $HOME/Library/Caches/helm/repository/* && rm -rf $HOME/Library/Caches/helmfile/*"
alias yqsort='yq -i '\''sort_keys(..)'\'''
alias y='yazi'

source <(kubectl completion zsh)
compdef kubecolor=kubectl

alias kitchen="/opt/homebrew/opt/ruby/bin/bundle exec kitchen"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Secrets (API keys etc.) — not tracked in git
[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

# Grok CLI
if [ -d "$HOME/.grok/bin" ]; then
  export PATH="$HOME/.grok/bin:$PATH"
  fpath=(~/.grok/completions/zsh $fpath)
  autoload -Uz compinit && compinit -C
fi

