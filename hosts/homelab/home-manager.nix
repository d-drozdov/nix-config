{ config, pkgs, ... }:
let
  dotfilesDir = ../shared/dotfiles;
in
{
  home.stateVersion = "24.11";
  # Username is overridden per host
  home.username = config.home.overrideUsername or "daniel";
  home.homeDirectory = "/home/${config.home.overrideUsername or "daniel"}";

  imports = [ ../shared/home-manager.nix ];

  home.packages = with pkgs; [ ]; 
}
