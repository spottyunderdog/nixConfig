{ self, inputs, ... }: {

  flake.nixosModules.networking = { ... }: {

    imports = [
      self.nixosModules.firewall
      self.nixosModules.networkmanager
      self.nixosModules.printing
      self.nixosModules.bluetooth
    ];

  };

}