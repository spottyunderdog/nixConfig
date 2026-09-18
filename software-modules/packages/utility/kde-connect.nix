{ self, inputs, ... }: {

  flake.nixosModules.kde-connect = { pkgs, config, lib, ... }: {

    options = {
      kde-connect.enable = lib.mkEnableOption "kde-connect";
    };

    config = lib.mkIf config.kde-connect.enable {

      programs.kdeconnect.enable = true;

      networking.firewall = rec {
        allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
        allowedUDPPortRanges = allowedTCPPortRanges;
      };

    };

  };

}