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
  ohMyPoshConfig = ../shared/dotfiles/oh-my-posh.yaml;
  alacrittyConfig = ../shared/dotfiles/alacritty.toml;
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
      "macos-fuse-t/homebrew-cask" = fuse-t-cask;
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

        home = {
          enableNixpkgsReleaseCheck = false;
          stateVersion = "24.11";

          packages = with pkgs; [

          ];
        };

        programs = {
          zsh = {
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
              # Initialize Oh My Posh with Zsh
              eval "$(oh-my-posh init zsh --config ${ohMyPoshConfig})"
            '';
          };

          oh-my-posh = {
            enable = true;
          };

          git = {
            enable = true;
            ignores = [
              "*.swp"
              "*.DS_Store"
            ];
            userName = name;
            userEmail = email;
            lfs.enable = true;
            extraConfig = {
              init.defaultBranch = "main";
            };
          };

          ssh = {
            enable = true;
            matchBlocks = {
              "github.com" = {
                user = "git";
                identitiesOnly = true;
                identityFile = "/Users/${user}/.ssh/id_ed25519_github";
              };
            };
          };
        };
        xdg.configFile."alacritty/alacritty.toml".text = builtins.readFile "${alacrittyConfig}";
      };

  };

}
