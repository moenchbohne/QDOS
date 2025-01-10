# random poke on start
select_random() {
    printf "%s\0" "$@" | shuf -z -n1 | tr -d '\0'
}

pokes=("pokeget 799 -s --hide-name" "pokeget 487 -s --hide-name" "pokeget 382 -s --hide-name" "pokeget 384 -s --hide-name" "pokeget 383 -s --hide-name")

selectedpoke=$(select_random "${pokes[@]}")
eval $selectedpoke

# aliases
alias reb="sudo nixos-rebuild switch"
alias rup="sudo nixos-rebuild switch --upgrade"
alias ff="fastfetch"
alias e="emacsclient -nw -a -c "emacs -nw""
alias wis="fortune | lolcat -f | chara say"
alias rel="source ~/.zshrc"
alias build="nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { } '"
alias doom="sudo nix run github:nix-community/nix-doom-emacs"

# starship 
eval  "$(starship init zsh)"

# Created by `pipx` on 2024-11-23 19:45:54
export PATH="$PATH:/home/quentin/.local/bin"
