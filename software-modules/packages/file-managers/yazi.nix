{ self, inputs, ...}: {

  flake.nixosModules.yazi = { config, lib, pkgs, ... }: {

    options = {
      yazi.enable = lib.mkEnableOption "yazi File Manager";
    };

    config = lib.mkIf config.yazi.enable {

      programs.yazi = {
        enable = true;
      };

    };

  };

}