{
  description = "My NixOS configuration managed with flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      homelab = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/homelab/services/open-webui.nix
          ./hosts/homelab/services/home-assistant.nix
          ./hosts/homelab/configuration.nix
        ];
      };
    };
  };
}