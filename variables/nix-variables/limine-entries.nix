{ self, inputs, ... }: {

  flake.nixosModules.limine-entries = { lib, config, ... }: {
    
    options = {
      nix-vars.limine-entries = lib.mkOption {
        type = lib.types.str;
      };
    };

    config = {
      nix-vars.limine-entries = lib.mkDefault ''
          /+Other systems and bootloaders
          //Efi Fallback
            protocol: efi
            path: boot():/EFI/BOOT/BOOTX64.EFI
        '';
    };



  };

}