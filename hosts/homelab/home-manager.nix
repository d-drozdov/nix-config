{ config, pkgs, ... }:
let
  dotfilesDir = ../shared/dotfiles;
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
    '';

  };

  programs.starship = {
    enable = true;
  };
}
