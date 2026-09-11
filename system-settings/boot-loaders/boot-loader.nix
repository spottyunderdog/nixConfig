{ self, inputs, ... }: {

  flake.nixosModules.boot-loader = { pkgs, config, ... }: {
      
      imports = [ self.nixosModules.grub ];

      efi.canTouchEfiVariables = true;

    };

  };

}
