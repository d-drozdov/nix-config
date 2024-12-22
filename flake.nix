{
  description = "My NixOS configuration managed with flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";       # Main NixOS package source
    home-manager.url = "github:nix-community/home-manager";   # Home Manager integration
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      homelab = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/homelab/configuration.nix       # NixOS system-level config
          ./hosts/homelab/services/open-webui.nix # Service: Open WebUI
          ./hosts/homelab/services/home-assistant.nix # Service: Home Assistant
          home-manager.nixosModules.home-manager  # Enable Home Manager
          {
            home-manager.users.daniel = import ./shared/home.nix; # User config for 'daniel'
          }
        ];
      };
    };
  };
}