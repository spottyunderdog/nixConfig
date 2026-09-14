{ self, inputs, ... }: {

  flake.nixosModules.nix-vars = { lib, config, ... }: {

    imports = [
      # variable modules
      self.nixosModules.limine-entries
      self.nixosModules.time-zone
      self.nixosModules.locale
      self.nixosModules.swap-size
      self.nixosModules.allowed-ssh-users
      self.nixosModules.ssh-ports
      self.nixosModules.tcp-ports
      self.nixosModules.udp-ports
    ];

  };

}