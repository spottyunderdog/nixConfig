{ self, inputs, ... }: {

  flake.nixosModules.boot-loader = { pkgs, config, ... }: {
      
    imports = [ 
      self.nixosModules.grub 
      self.nixosModules.limine
    ];

    boot.loader.efi.canTouchEfiVariables = true;

    grub.enable = lib.mkDefault false;
    limine.enable = lib.mkDefault false;

  };
}
