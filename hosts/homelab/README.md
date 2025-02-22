# NixOS Config

```
.  
├── configuration.nix               # Set up system specific things.install packages              
├── hardware-configuration.nix      # Auto-generated by NixOS probably shouldn't be touched
├── home-manager.nix                # Manage config files
├── packages.nix                    # Manage Nix Packages
└── services                        # Folder containing and services that are running on the host
    ├── home-assistant.nix          
    └── open-webui.nix
```

## Services:
- [Open-WebUI](http://100.123.25.72:8123/)
- [Home-Assistant](http://100.123.25.72:8080/)

## Fresh Install Steps:

1. Clone repo
1. In home manager config uncomment persisent others
1. Install nix using determinate installer
1. Run the following:
```bash
nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake .#darwin
```
5. Comment out persistent others

## Helpful Notes:

If you ever get a NetworkManager-wait-online.service - Network Manager Wait Online error try the following:
```bash
sudo nixos-rebuild boot --flake .#homelab 
sudo reboot
sudo nixos-rebuild switch --flake .#homelab
```