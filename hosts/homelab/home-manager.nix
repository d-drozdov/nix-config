{ config, pkgs, ... }:
let
  dotfilesDir = ./dotfiles;
in
{
  home.stateVersion = "24.11";
  # Username is overridden per host
  home.username = config.home.overrideUsername or "daniel";
  home.homeDirectory = "/home/${config.home.overrideUsername or "daniel"}";

  home.packages = with pkgs; [ ];

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
        "docker"
        "aws"
      ];
    };
    initExtra = ''
      eval "$(oh-my-posh init zsh --config ${dotfilesDir}/oh-my-posh.yaml)"
    '';

  };

  programs.oh-my-posh = {
    enable = true;
  };
}
