{ self, inputs, ... }: {

  flake.homeModules.shell-config-modules = { ... }: {

    imports = [
      self.homeModules.bash
      self.homeModules.fish
      self.homeModules.zsh
    ];

  };

}
