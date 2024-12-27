{ config, pkgs, ... }:
let 
dotfilesDir = ./dotfiles;
user = "daniel";
in 
{
    users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "24.11";
      };
   };
  };


  
  # fonts.fontconfig.enable = true;
  # Cross-platform packages (shared across macOS and NixOS)
  # home-manager.home.packages = with pkgs; [
  #   # Packages
  #   vim         
  #   git         
  #   curl        
  #   wget        
  #   zip         
  #   unzip       
  #   tmux        
  #   tree        
  #   jq          
  #   htop        
  #   lf          
  #   awscli2     
  #   docker      
  #   docker-compose

  #   # Fonts
  #   fira-code
  #   jetbrains-mono
  #   source-code-pro
  #   noto-fonts-emoji
  #   nerd-fonts.fira-code
  #   nerd-fonts.jetbrains-mono
  # ];


  # # Zsh
  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   syntaxHighlighting.enable = true;
  #   oh-my-zsh = {
  #     enable = true;
  #     plugins = [ "git" "z" "docker" "aws" ];
  #   };
  #   # initExtra = ''
  #   #   eval "$(oh-my-posh init zsh --config ../../shared/dotfiles/oh-my-posh.yaml)"
  #   # '';

  # };

  # # programs.oh-my-posh = {
  # #   enable = true;
  # # };
}