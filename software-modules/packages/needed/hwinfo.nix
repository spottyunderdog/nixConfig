{ self, inputs, ...}: {

  flake.nixosModules.hwinfo = { pkgs, lib, config, ... }: {

    options = {
      hwinfo.enable = lib.mkEnableOption "hwinfo";
    };

    config = lib.mkIf config.hwinfo.enable {

      environment.systemPackages = [ pkgs.hwinfo ];

    };

  };

}