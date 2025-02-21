{ pkgs, ... }:

with pkgs;
let
  shared-packages = import ../shared/packages.nix { inherit pkgs; };
in
shared-packages
++ [
  iputils # Network tools (e.g., "ping")
  openssh # Secure shell (SSH server/client)
  systemd # NixOS init system
  ntp # Network time protocol
  coreutils # Core Unix utilities
  bluez # Bluetooth stack
  bluez-tools # Additional Bluetooth tools
  docker
  docker-compose
  speedtest-cli
]
