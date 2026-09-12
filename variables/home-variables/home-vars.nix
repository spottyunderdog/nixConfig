{ self, inputs, ... }: {

  flake.homeModules.home-vars = { lib, config, ... }: {

    imports = [
      self.homeModules.shell-aliases
    ];

  };

}