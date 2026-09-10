{ self, inputs, ... }: {

  flake.nixosModules.intel-drivers = { pkgs, config, lib, ... }: {

    options = {
        intel-drivers.enable = lib.mkEnableOption "Enable Intel drivers";
    };

    config = lib.mkIf config.intel-drivers.enable {
      services.xserver.videoDrivers = [ "modesetting" ];
    };

  };

}
