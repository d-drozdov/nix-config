{ config, pkgs, ... }: 

{
  home.stateVersion = "24.11";

  # Username is overridden per host
  home.username = config.home.overrideUsername or "daniel";
  home.homeDirectory = "/home/${config.home.overrideUsername or "daniel"}";

  # Cross-platform packages (shared across macOS and NixOS)
  home.packages = with pkgs; [
    # Packages
    vim         
    git         
    curl        
    wget        
    zip         
    unzip       
    tmux        
    tree        
    jq          
    starship    
    htop        
    lf          
    awscli2     
    docker      
    docker-compose 

    # Fonts
    fira-code
    jetbrains-mono
    source-code-pro
    noto-fonts-emoji
    font-awesome


  ];

  # Zsh (Oh My Zsh and Starship prompt shared across platforms)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "docker" "aws" ];
    };
  };
  
  programs.starship.enable = true; # Starship shell prompt
  xdg.configFile."starship.toml".source = builtins.toPath ./dotfiles/starship.toml; # Reference the dotfile
}