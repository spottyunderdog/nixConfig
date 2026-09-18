{ self, inputs, ... }: {

  flake.homeModules.home-vars = { lib, config, ... }: {

    imports = [
      # where to but any variables i use for home manager (ATM 0)
    ];

  };

}