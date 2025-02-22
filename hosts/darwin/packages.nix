{ pkgs, ... }:

with pkgs;
let
  shared-packages = import ../shared/packages.nix { inherit pkgs; };
in
shared-packages
++ [
  raycast
  alt-tab-macos
  rectangle
  zoom-us
  ngrok
  flutter
  cocoapods
]
