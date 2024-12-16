{ pkgs, ... }:

with pkgs; [
  # General Packages
  vim
  git      # Version control
  curl     # Command-line tool for transferring data
  wget     # Network downloader
  zip

  # Text and Terminal Utilities
  htop     # Resource monitor
  tmux     # Terminal multiplexer
  zsh      # Shell
  tree     # Directory tree viewer
  jq       # JSON processor
  lf       # Terminal File Manager

  # Development Tools
  gcc      # Compiler
  docker 
  docker-compose

  # Networking Tools
  iputils  # Network utilities (ping, traceroute, etc.)
  openssh  # SSH client

  # System Utilities
  systemd  # System and service manager
  ntp      # Network time protocol
  coreutils# Basic file, shell, and text utilities
]

