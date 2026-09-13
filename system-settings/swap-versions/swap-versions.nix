{ self, inputs, ... }: {

  flake.nixosModules.swap-versions = { ... }: {

    imports = [
      self.nixosModules.swap
      self.nixosModules.zswap
      self.nixosModules.zram
    ];

  };

}