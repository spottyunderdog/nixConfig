{ self, inputs, ... }: {

  flake.nixosModules.mediaApps = { config, pkgs, lib, ... }: {

    options = {
      mediaApps.enable = lib.mkEnableOption "mediaApps";
    };

    config = lib.mkIf config.mediaApps.enable {

      environment.systemPackages = with pkgs; [
        jellyfin-desktop
        obs-studio
        spotify
        vlc
      ];

    };

  };

}
