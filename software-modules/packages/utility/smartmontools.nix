{ self, inputs, ... }: {

  flake.nixosModules.smartmontools = { pkgs, config, lib, ... }: {

    options = {
      smartmontools.enable = lib.mkEnableOption "smartmontools";
    };

    config = lib.mkIf config.smartmontools.enable {

      environment.systemPackages = [ pkgs.smartmontools ];

    };

  };

}