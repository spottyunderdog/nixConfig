{ self, inputs, ... }: {

  flake.nixosModules.file-managers = { ... }: {

    imports = [
      self.nixosModules.dolphin
      self.nixosModules.thunar
    ];

  };

}