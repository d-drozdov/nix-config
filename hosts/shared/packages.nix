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
  nixfmt-rfc-style
  direnv
  devenv

  # GUI Applications
  alacritty
  spotify
  vscode
  brave
]
