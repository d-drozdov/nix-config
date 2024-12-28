# Shared Flakes/Configs

These files can be used between platforms and allow for editing in one spot

```
.
├── dotfiles                # Any config or dotfiles go here
│   ├── alacritty.toml
│   └── oh-my-posh.yaml
├── home-manager.nix        # Shared home-manager config
└── packages.nix            # Platform agnostic packages I want all machines
```