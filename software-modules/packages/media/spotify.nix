{ self, inputs, ... }: {

  flake.nixosModules.spotify = { config, lib, pkgs, ... }: {

    option = {
      spotify.enable = lib.mkEnableOption "Spotify Desktop App";
    };

    config = lib.mkIf config.spotify.enable {

      environment.sytemPackages = [ pkgs.spotify ];

    };

  };

}