{ self, inputs, ... }: {

  flake.nixosModules.qbittorrent = { pkgs, config, lib, ... }: {

    options = {
      qbittorrent.enable = lib.mkEnableOption "qbittorrent";
    };

    config = lib.mkIf config.qbittorrent.enable {

      environment.systemPackages = [ pkgs.qbittorrent ];

    };

  };

}