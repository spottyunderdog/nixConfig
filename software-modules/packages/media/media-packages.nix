{ self, inputs, ... }: {

  flake.nixosModules.media-packages = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.jellyfin-desktop
      self.nixosModules.obs-studio
      self.nixosModules.spotify
      self.nixosModules.vlc
    ];

    options = {
      media-packages.enable = lib.mkEnableOption "mediaApps";
    };

    config = lib.mkIf config.media-packages.enable {

      jellyfin-desktop.enable = lib.mkDefault true;
      obs-studio.enable = lib.mkDefault true;
      spotify.enable = lib.mkDefault true;
      vlc.enable = lib.mkDefault true;

    };

  };

}
