{ self, inputs, ... }: {

  flake.nixosModules.boot-loader = { pkgs, config, ... }: {
      
    imports = [ self.nixosModules.grub ];

    boot.loader.efi.canTouchEfiVariables = true;

  };
}
