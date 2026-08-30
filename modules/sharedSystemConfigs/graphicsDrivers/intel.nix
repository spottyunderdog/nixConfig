{ self, inputs, ... }: {

  flake.nixosModules.intel = { pkgs, config, lib, ... }: {

    options = {
        intelDrivers.enable = lib.mkEnableOption "Enable Intel drivers";
    };

    config = lib.mkIf config.intelDrivers.enable {
      services.xserver.videoDrivers = [ "modesetting" ];
    };

  };

}
