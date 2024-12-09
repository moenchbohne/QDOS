# random poke on start
select_random() {
    printf "%s\0" "$@" | shuf -z -n1 | tr -d '\0'
}

pokes=("pokeget 487 -s --hide-name" "pokeget 382 -s --hide-name" "pokeget 384 -s --hide-name" "pokeget 383 -s --hide-name")

selectedpoke=$(select_random "${pokes[@]}")
eval $selectedpoke

# aliases
alias e="emacs -nw"
alias w="curl wttr.in/Celle"
alias ff="fastfetch"
alias pok="pokeget 382 383 384 -s --hide-name"
alias pok2="pokeget 487 -s --hide-name"
alias reb="sudo nixos-rebuild switch"
alias rep="sudo nixos-rebuild switch --upgrade --verbose"
alias build="echo PLACEHOLDER"
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
