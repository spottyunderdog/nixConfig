{ self, inputs, ... }: {

  flake.nixosModules.desktop-enviornments = { ... }: {

    imports = [
      self.nixosModules.wayland
      self.nixosModules.x11
    ];

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

  };

}