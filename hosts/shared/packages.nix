{ pkgs, ... }:
with pkgs;
[
  # CLI TOOLS
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
  nixfmt-rfc-style

  # GUI Applications
  alacritty
  spotify
  vscode
  brave
]
