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