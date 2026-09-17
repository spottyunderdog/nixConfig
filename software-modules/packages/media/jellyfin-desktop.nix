{ self, inputs, ... }: {

  flake.nixosModules.jellyfin-desktop = { config, lib, pkgs, ... }: {

    options = {
      jellyfin-desktop.enable = lib.mkEnableOption "Jellyfin Desktop Client";
    };

    config = lib.mkIf config.jellyfin-desktop.enable {

      environment.systemPackages = [ pkgs.jellyfin-desktop ];

    };

  };

}