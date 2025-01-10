# random poke on start
select_random() {
    printf "%s\0" "$@" | shuf -z -n1 | tr -d '\0'
}

pokes=("pokeget 487 -s --hide-name" "pokeget 382 -s --hide-name" "pokeget 384 -s --hide-name" "pokeget 383 -s --hide-name")

selectedpoke=$(select_random "${pokes[@]}")
eval $selectedpoke

# aliases
alias e="emacsclient -nw -c -a 'emacs -nw' "
alias w="curl wttr.in/Celle"
alias ff="fastfetch"
alias pok="pokeget 382 383 384 -s --hide-name"
alias pok2="pokeget 487 -s --hide-name"
# only work with flake.lock chowned to the user executing nh
alias reb="nh os switch /etc/nixos"
alias rep="nh os switch /etc/nixos --update"
alias nixcp="cp /etc/nixos/* ~/GitRepos/QDOS/nix-config"
alias rel="source ~/.zshrc"
alias build="nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { } '"
alias doom="sudo nix run github:nix-community/nix-doom-emacs"

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
