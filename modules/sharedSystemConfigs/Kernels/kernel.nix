{ self, inputs, ... }: {

  flake.nixosModules.kernel = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.cachyKernels
      self.nixosModules.linuxKernels
    ];

  };

}
