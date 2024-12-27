{ config, pkgs, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, ... }:
let 
ohMyPoshConfig = ../../shared/dotfiles/oh-my-posh.yaml;
user = "daniel";
in 
{
    users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };


  nix-homebrew = {
    enable = true;  # Enable Homebrew integration
    enableRosetta = true;  # Enable Rosetta for Intel emulation on Apple Silicon
    user = "daniel";  # User owning the Homebrew prefix
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
    };
    mutableTaps = false;  # Disallow modifying taps
    autoMigrate = true;   # Enable auto-migration of Homebrew installations
  };


  homebrew = {
    enable = true;
    
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    casks = pkgs.callPackage ./casks.nix { };
    # brews = [
    #   "cocoapods"
    # ];

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = {
      "Bitwarden" = 1352778147; # Installed this way to allow for browser integration
      # "Tailscale" = 1475387142;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "24.11";

         packages = with pkgs; [

        ];
      };

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "z" "docker" "aws" ];
        };
        initExtra = ''
          eval "$(oh-my-posh init zsh --config ${ohMyPoshConfig})"
        '';

      };

      programs.oh-my-posh = {
        enable = true;
      };
    };

  };
}