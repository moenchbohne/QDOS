# aliases
alias e="emacs -nw"
alias w="curl wttr.in/Celle"
alias ff="fastfetch"
alias pok="pokeget 382 383 384 -s"
alias reb="sudo nixos-rebuild switch"
alias rel="source ~/.zshrc"

# replace old shit
alias cd="z"
alias cdi="zi"
alias cat="bat"
alias ls="eza"

# zoxide
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)

# starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

export PATH=$PATH:/home/quentin/.spicetify
