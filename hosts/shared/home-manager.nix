{ config, pkgs, ... }:
let
  dotfilesDir = ./dotfiles;
  name = "Daniel Drozdov";
  email = "ddrozdov12@gmail.com";
in
{
  # Common home-manager configuration
  programs = {
    zsh = {
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
          "direnv"
        ];
      };
      initExtra = ''
      '';
    };

    starship.enable = true;

    git = {
      enable = true;
      userName = name;
      userEmail = email;
      lfs.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
      ignores = [
        "*.swp"
        "*.DS_Store"
      ];
    };
  };

  # Shared dotfiles
  xdg.configFile = {
    "starship.toml".text = builtins.readFile "${dotfilesDir}/starship.toml";
    "alacritty/alacritty.toml".text = builtins.readFile "${dotfilesDir}/alacritty.toml";
  };
}
