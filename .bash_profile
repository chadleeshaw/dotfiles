# Suppress macOS bash deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
ulimit -n 2048

# Go
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export GOOS="darwin"
export GOARCH="arm64"
export GOBIN=$GOPATH/bin

# Java
export JAVA_HOME=/opt/homebrew/opt/openjdk
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Ruby (chef/kitchen)
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# General PATH additions
export PATH=$PATH:$HOME/src/pops/salt-states/bin:${GOPATH}/bin:${GOROOT}/bin

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Gem
export GEM_HOME=$HOME/.gem

# Kubernetes
export KUBECONFIG=~/.kube/config

# Aliases — general
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -la"
alias vi='nvim'
alias vim='nvim'
alias x='exit'
alias c='clear'
alias huh='ps aux | grep '

# Aliases — git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

# Aliases — kubernetes
alias k='kubecolor'
alias kx='kubectx'
alias kn='kubens'

# Aliases — tools
alias t='terraform'
alias m='mrmeseeks'
alias sre='sre-tui'
alias code="open -a 'Visual Studio Code'"
alias renew='sudo ifconfig en6 down && sudo ifconfig en6 up'
alias gr="GOOS=darwin GOARCH=arm64 go run"
alias hcc="rm -rf $HOME/Library/Caches/helm/repository/* && rm -rf $HOME/Library/Caches/helmfile/*"
alias yqsort='yq -i '\''sort_keys(..)'\'''
alias kitchen="/opt/homebrew/opt/ruby/bin/bundle exec kitchen"

# Aliases — incus remotes
alias ise='incus remote switch se'
alias isw='incus remote switch sw'
alias itp='incus remote switch tp'

# kubectl completion
source <(kubectl completion bash) 2>/dev/null
complete -o default -F __start_kubectl k

# Secrets (API keys etc.) — not tracked in git
[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets
