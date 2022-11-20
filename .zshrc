fpath=(~/.zsh $fpath)

autoload -Uz compinit
compinit -u

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export EDITOR="nvim"

eval "$(starship init zsh)"
