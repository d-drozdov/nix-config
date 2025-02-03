{
  config,
  pkgs,
  nix-homebrew,
  homebrew-bundle,
  homebrew-core,
  homebrew-cask,
  fuse-t-cask,
  ...
}:
let
  dotfilesDir = ../shared/dotfiles;
  user = "daniel";
  name = "Daniel Drozdov";
  email = "ddrozdov12@gmail.com";
in
{
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  # Set up nix-homebrew config, usually stored in the flake.nix, but I moved it here to clean up the main flake
  nix-homebrew = {
    enable = true; # Enable Homebrew integration
    enableRosetta = true; # Enable Rosetta for Intel emulation on Apple Silicon
    user = "${user}"; # User owning the Homebrew prefix
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "macos-fuse-t/homebrew-cask" = fuse-t-cask; # Tapping a cask for cryptomator
    };
    mutableTaps = false; # Disallow modifying taps
    autoMigrate = true; # Enable auto-migration of Homebrew installations
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    casks = pkgs.callPackage ./casks.nix { };
    brews = [ ];

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = {
      "Bitwarden" = 1352778147; # Installed this way to allow for browser integration
      "Tailscale" = 1475387142; # I like the gui
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        imports = [ ../shared/home-manager.nix ];

        home = {
          enableNixpkgsReleaseCheck = false;
          stateVersion = "24.11";
          packages = with pkgs; [ ];
        };

        programs = {
          # Darwin-specific ZSH additions
          zsh.shellAliases = {
            "nix-switch" = "darwin-rebuild switch --flake $HOME/nix-config/#darwin";
          };

          # Darwin-specific SSH configuration
          ssh = {
            enable = true;
            matchBlocks = {
              "github.com" = {
                user = "git";
                identitiesOnly = true;
                identityFile = "/Users/${user}/.ssh/id_ed25519_github";
              };
              "homelab" = {
                hostname = "100.123.25.72";
                host = "homelab";
                user = " daniel";
                identitiesOnly = true;
                identityFile = "/Users/${user}/.ssh/id_ed25519_homelab";
              };
            };
          };
        };
      };
  };
}
