{ self, inputs, ... }: {

  flake.nixosModules.nix-vars = { lib, config, ... }: {

    imports = [
      # variable modules
      self.nixosModules.limine-entries
      self.nixosModules.time-zone
      self.nixosModules.locale
    ];

  };

}