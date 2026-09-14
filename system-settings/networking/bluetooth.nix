{ self, inputs, ... }: {

  flake.nixosModules.bluetooth = { config, lib, ... }: {

    options = {
      bluetooth.enable = lib.mkEnableOption "Use Bluetooth";
    };

    config = lib.mkIf config.bluetooth.enable {

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
          };

          Policy = {
            AutoEnable = true;
          };
          
        };
      };

    };

  };

}