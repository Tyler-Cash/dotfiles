# Better defaults
alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias lt='eza --tree --icons --level=2'
alias cat='bat'

# Kubernetes
alias k='kubectl'
alias kctx='kubectx'
alias kns='kubens'

# Terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'

# Git
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias glog='git log --oneline --graph --decorate'

# chezmoi
alias cz='chezmoi'
alias czd='chezmoi diff'
alias cza='chezmoi apply'
alias cze='chezmoi edit'

# lazygit
alias lg='lazygit'

# bottom — replaces system top with a richer monitor
alias top='btm'

# direnv — quick allow shorthand
alias da='direnv allow'

# Better system defaults
alias du='dust'
alias df='duf'
alias ps='procs'

# tmux
alias t='tmux'
alias ta='tmux attach-session -t'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'

# forgit interactive git (supplements the plain git aliases above)
alias gla='forgit::log'       # interactive log with preview
alias gda='forgit::diff'      # interactive diff with fzf
alias gaa='forgit::add'       # interactive staging
alias gcoa='forgit::checkout_branch'  # interactive branch checkout
