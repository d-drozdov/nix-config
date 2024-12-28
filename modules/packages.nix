{ pkgs, ... }:
with pkgs;
[
  docker # Docker for managing containers at the system level
  docker-compose # Compose tool for Docker
  iputils # Network tools (e.g., "ping")
  openssh # Secure shell (SSH server/client)
  systemd # NixOS init system
  ntp # Network time protocol
  coreutils # Core Unix utilities
  bluez # Bluetooth stack
  bluez-tools # Additional Bluetooth tools
]
