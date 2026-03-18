{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # nix, so my code fucking rocks
    nixd
    nil
    nixfmt-rfc-style

    # toml + yaml
    taplo
    yaml-language-server

    # python
    pyright
    ruff
  ];
}
