{ self, inputs, ... }: {

  flake.nixosModules.podman = { config, pkgs, lib, ... }: {

    options = {
      podman.enable = lib.mkEnableOption "Add Podman Container Supports";
    };

    config = lib.mkIf config.podman.enable {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
      


    };

  };

}