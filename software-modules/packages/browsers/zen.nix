{ self, inputs, ...}: {

  flake.nixosModules.zen = { config, lib, pkgs, ... }: {

    options = {
      zen.enable = lib.mkEnableOption "zen";
    };

    config = lib.mkIf config.zen.enable {

      environment.systemPackages = with pkgs; [ 
        inputs.omniflake.flakes.zen-browser-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

    };

  };

}