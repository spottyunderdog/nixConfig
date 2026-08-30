{ self, inputs, ... }: {

  flake.nixosConfigurations.drNix = inputs.nixpkgs.lib.nixosSystem {

    modules = [
      self.nixosModules.drNixConfiguration
    ];

  };

}
