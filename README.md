# Nix Config

This is my Nix Config currently running on my Apple Silicon Macbook running nix-darwin and my Intel-Based Homelab running NixOS.

> Please note, while I do use home-manager I do not manage any packages with it. There are a couple of reason for that but the main one is convience, on mac there is no easy for spotlight to index GUI applications without using something like mac-app-utils which I dont want to depend on. My main use for is home-manager to manage dotfiles and configurations of certain programs. 

## Getting Started on Mac
### Install nix 
> We use the Determinate Installer because it provides an easy way to uninstall should you ever want to remove Nix.

Use the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer)



### Install nix-darwin
> Make sure you are in the root of the directory

`nix run nix-darwin -- switch --flake .#darwin`

### Done!
You system should now be built and ready for use. Going forward you should be able to run the below command to rebuild

`darwin-rebuild switch --flake .#darwin`
