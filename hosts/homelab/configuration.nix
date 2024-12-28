# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{
  config,
  pkgs,
  lib,
  ...
}:

# Import the common packages from the shared location
let
  packages = import ../shared/packages.nix { inherit pkgs; };
  sharedFonts = import ../shared/fonts.nix { inherit pkgs; };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking configuration
  networking = {
    hostName = "homelab"; # Define your hostname
    networkmanager.enable = true; # Enable networking
    firewall.allowedTCPPorts = [ 22 ]; # Open port 22 for SSH
  };

  # Configure time zone and localization
  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable Nix Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Configure keyboard layout in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable printing support (CUPS)
  services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true; # Enables support for Bluetooth
    powerOnBoot = true; # Powers up the default Bluetooth controller on boot
  };

  # Enable sound using PipeWire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Uncomment below to enable JACK support
    # jack.enable = true;
  };

  # Define user account
  users.users.daniel = {
    isNormalUser = true;
    description = "Daniel";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ]; # Add user to groups
    shell = pkgs.zsh;
    packages = packages; # Add user-specific packages here
  };

  # Disable password for sudo for the "daniel" user
  security.sudo.extraRules = [
    {
      users = [ "daniel" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Enable additional programs
  programs = {
    firefox.enable = true; # Install Firefox
    nix-ld.enable = true; # Enable nix-ld (for vscode-server)
    zsh.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install system-wide packages
  environment.systemPackages = packages;
  fonts.packages = sharedFonts;

  # Enable desired services
  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false; # Disable SSH password authentication
    };

    blueman.enable = true; # Enable Blueman Bluetooth Manager
    tailscale.enable = true; # Enable Tailscale VPN
  };

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Use Docker as OCI containers backend
  virtualisation.oci-containers.backend = "docker";

  # Define the NixOS release version for stateful data
  system.stateVersion = "24.11"; # Did you read the comment?
}
