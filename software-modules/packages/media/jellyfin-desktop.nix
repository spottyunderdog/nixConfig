{ self, inputs, ... }: {

  flake.nixosModules.jellyfin-desktop = { config, lib, pkgs, ... }: {

    option = {
      jellyfin-desktop.enable = lib.mkEnableOption "Jellyfin Desktop Client";
    };

    config = lib.mkIf config.jellyfin-desktop.enable {

      environment.sytemPackages = [ pkgs.jellyfin-desktop ];

    };

  };

}