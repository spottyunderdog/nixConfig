{ self, inputs, ...}: {

  flake.nixosModules.vivaldi = { config, lib, pkgs, ... }: {

    options = {
      vivaldi.enable = lib.mkEnableOption "vivaldi";
    };

    config = lib.mkIf config.vivaldi.enable {

      environment.systemPackages = with pkgs; [ 
        vivaldi
        vivaldi-ffmpeg-codecs
      ];

    };

  };

}