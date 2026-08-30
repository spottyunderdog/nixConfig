{ self, inputs, ... }: {

  flake.nixosModules.users = { config, pkgs, ... }: {

    imports = [
      # Import User Configurations Here
      # User modules should follow the format of self.nixosModules."users-<username>"
      self.nixosModules."users-spotty"
    ];

  };

}