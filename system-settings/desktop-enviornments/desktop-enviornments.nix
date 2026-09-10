{ self, inputs, ... }: {

  flake.nixosModules.desktop-enviornments = { ... }: {
    imports = [
      self.nixosModules.wayland
      self.nixosModules.x11
    ];
  };

}