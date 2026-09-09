{ self, inputs, ... }: {

  flake.nixosModules.podman = { config, pkgs, lib, ... }: {

    options = {
      podman.enable = lib.mkEnableOption "Add Podman Container Supports";
    };

    config = lib.mkIf config.podman.enable {

      docker.enable = lib.mkForce false;

      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      environment.systemPackages = with pkgs; [
        podman-compose
        docker-compose
        podman-desktop
      ];

    };

  };

}