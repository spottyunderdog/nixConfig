{ self, inputs, ... }: {

  flake.nixosModules.grub = { config, lib, ... }: {

    options = {
      grub.enable = lib.mkEnableOption "Grub Bootloader";
    };

    config = lib.mkIf config.grub.enable {

      boot.loader.grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };

    };

  };


}