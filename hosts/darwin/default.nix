{
  config,
  pkgs,
  nixpkgs,
  ...
}:

let
  user = "daniel";
  packages = import ./packages.nix { inherit pkgs; };
  sharedFonts = import ../shared/fonts.nix { inherit pkgs; };
in

{
  imports = [
    ./home-manager.nix
  ];


  # Use TouchID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;
    settings.trusted-users = [
      "@admin"
      "${user}"
    ];

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Set up alaising for applications downloaded via nix on mac
  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';

  nixpkgs.config.allowUnfree = true;
  # Load configuration that is shared across systems
  environment.systemPackages = packages;
  fonts.packages = sharedFonts;

  system = {
    stateVersion = 5;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        mouse-over-hilite-stack = true;
        orientation = "bottom";

        minimize-to-application = true;
        tilesize = 48;
        magnification = true;
        largesize = 72;
        persistent-apps = [
          "${pkgs.brave}/Applications/Brave Browser.app"
          "${pkgs.alacritty}/Applications/Alacritty.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
          "${pkgs.spotify}/Applications/Spotify.app"
          "/System/Applications/Messages.app"
        ];
        # Recomment if on new machine
        # persistent-others = [
        #   "/Users/${user}/Pictures/Screenshots"
        #   "/Users/${user}/Downloads"
        # ];
      };


      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        FXPreferredViewStyle = "clmv";
        _FXShowPosixPathInTitle = false;
      };

      screencapture.location = "/Users/${user}/Pictures/Screenshots";

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };

    # keyboard = {
    #   enableKeyMapping = true;
    # };
  };
}
