{
  description = "My NixOS configuration managed with flakes";

  # Define inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # You can pin this to a stable branch if needed
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  # Outputs block where you use @inputs to access the inputs
  outputs = { self, nixpkgs, vscode-server, ... }@inputs: {
    # Define NixOS configurations for specific hostnames
    nixosConfigurations = {
      homelab = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";  # Use "aarch64-linux" for ARM systems

        modules = [
          ./hosts/homelab/configuration.nix
          vscode-server.nixosModules.default
        ];
      };
    };
  };
}

