{ self, inputs, ...}: {

  flake.nixosModules.firefox = { config, lib, pkgs, ... }: {

    options = {
      firefox.enable = lib.mkEnableOption "Firefox";
    };

    config = lib.mkIf config.firefox.enable {

      environment.systemPackages = [ pkgs.firefox ];

    };

  };

}