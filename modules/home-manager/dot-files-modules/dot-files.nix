{ self, inputs, ... }: {

  flake.homeModules.dot-files = { ... }: {

    imports = [
      self.homeModules.niri-dots
      self.homeModules.hyprland-dots
      self.homeModules.kitty-dots
      self.homeModules.noctalia-dots
    ];

  };

}
