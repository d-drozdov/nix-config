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
  speedtest-cli

  # GUI Applications
  alacritty
  spotify
  vscode
]
