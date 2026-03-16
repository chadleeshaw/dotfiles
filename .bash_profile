# Bash Colors
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# ENV's
eval "$(/opt/homebrew/bin/brew shellenv)"
ulimit -n 2048
export BASH_SILENCE_DEPRECATION_WARNING=1
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:/Users/chad.shaw/src/pops/salt-states/bin:${GOPATH}/bin:${GOROOT}/bin

# Alias's
alias ll='ls -Glah'
alias vi='vim'
alias x='exit'
alias c='clear'
alias huh='ps aux | grep '
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias renew='sudo ifconfig en6 down && sudo ifconfig en6 up'
alias k='kubectl'
complete -F __start_kubectl k
alias m='mrmeseeks'
alias kx='kubectx'
alias kns='kubens'
alias ll='ls -la'

# Powerline
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $? \
	    -jobs $(jobs -p | wc -l) \
	    -cwd-max-depth 3 \
	    -hostname-only-if-ssh \
        -modules cwd,git,kube \
        -theme ~/.powerline/config.json
	)"
    #set "?"
}
if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# K8's
export KUBECONFIG=~/.kube/config
# export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
# source <(kubectl completion bash)

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/chad.shaw/.cache/lm-studio/bin"
# End of LM Studio CLI section

