{ self, inputs, ... }: {

  flake.nixosModules.grub = { config, lib, ... }: {
    boot.loader = {

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;

      };

    };

  };


}