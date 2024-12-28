{ config, pkgs, ... }:
let
  dotfilesDir = ./dotfiles;
in
{
  home.stateVersion = "24.11";
  # Username is overridden per host
  home.username = config.home.overrideUsername or "daniel";
  home.homeDirectory = "/home/${config.home.overrideUsername or "daniel"}";

  # fonts.fontconfig.enable = true;
  # Cross-platform packages (shared across macOS and NixOS)
  home.packages = with pkgs; [
    # Packages
    vim
    git
    curl
    wget
    zip
    unzip
    tmux
    tree
    jq
    htop
    lf
    awscli2
    docker
    docker-compose

    # Fonts
    fira-code
    jetbrains-mono
    source-code-pro
    noto-fonts-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

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
