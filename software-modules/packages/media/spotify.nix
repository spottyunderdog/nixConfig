{ self, inputs, ... }: {

  flake.nixosModules.spotify = { config, lib, pkgs, ... }: {

    options = {
      spotify.enable = lib.mkEnableOption "Spotify Desktop App";
    };

    config = lib.mkIf config.spotify.enable {

      environment.systemPackages = [ pkgs.spotify ];

    };

  };

}