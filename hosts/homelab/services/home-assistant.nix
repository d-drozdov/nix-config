{ config, pkgs, ... }:

{
  config.virtualisation.oci-containers.containers = {
    home-assistant = {
      image = "ghcr.io/home-assistant/home-assistant:stable";
      volumes = [
        "/var/lib/home-assistant/config:/config"
        "/etc/localtime:/etc/localtime:ro"
        "/run/dbus:/run/dbus:ro"
      ];
      environment = { TZ = "America/New_York"; };
      extraOptions = [
        "--network=host" 
        "--privileged=true"
      ];
    };
  };
}
