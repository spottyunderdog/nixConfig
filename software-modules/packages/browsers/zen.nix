{ self, inputs, ...}: {

  flake.nixosModules.zen = { config, lib, pkgs, ... }: {

    options = {
      zen.enable = lib.mkEnableOption "zen";
      zen.shortcut-version = lib.mkOption {
        type = lib.types.int;
        default = 21;
      };
    };

    config = lib.mkIf config.zen.enable {

      environment.systemPackages = with pkgs; [ 
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
      ];

    };

  };

}