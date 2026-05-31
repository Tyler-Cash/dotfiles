# zsh-completions — must be added to fpath before compinit (called in completions.zsh)
fpath=("$(brew --prefix)/share/zsh-completions" $fpath)

# Plugins
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$(brew --prefix)/share/forgit/forgit.plugin.zsh"
source "$(brew --prefix)/share/zsh-you-should-use/you-should-use.plugin.zsh"

# fzf shell integration (fuzzy history ctrl+r, file picker ctrl+t, cd alt+c)
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

# Bind up/down arrows to history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
