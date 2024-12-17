{ config, pkgs, ... }:

{
  config.virtualisation.oci-containers.containers = {
    home-assistant = {
      image = "ghcr.io/home-assistant/home-assistant:stable";
      volumes = [
        "/etc/home-assistant/config:/config"
        "/etc/localtime:/etc/localtime:ro"
      ];
      environment = { TZ = "America/New_York"; };
      extraOptions = [
        "--network=host" 
        "--privileged=true"
      ];
    };
  };
}
