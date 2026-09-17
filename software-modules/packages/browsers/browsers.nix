{ self, inputs, ...}: {

  flake.nixosModules.browsers = { ... }: {

    imports = [
      self.nixosModules.firefox
      self.nixosModules.vivaldi
      self.nixosModules.zen
    ];

  };

}