{ self, inputs, ... }: {

  flake.nixosModules.boot-loader = { pkgs, config, lib, ... }: {
      
    imports = [ 
      self.nixosModules.grub 
      self.nixosModules.limine
    ];

    boot.loader.efi.canTouchEfiVariables = true;

    grub.enable = lib.mkDefault false;
    limine.enable = lib.mkDefault false;

  };
}
