{ self, inputs, ... }: {

  flake.nixosModules.kernels = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.cachyos-kernels
      self.nixosModules.linux-kernels
    ];

  };

}
