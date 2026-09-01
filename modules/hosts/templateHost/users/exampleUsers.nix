{ self, inputs, ... }: {

  flake.nixosModules.exampleUsers = { config, pkgs, ... }: {

    imports = [
      # Import User Configurations Here
      # User modules should follow the format of self.nixosModules."<hostname>-<username>"
      self.nixosModules."example-nix"
    ];

  };

}