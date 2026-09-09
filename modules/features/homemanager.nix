{ self, inputs, ... }: {

  flake.nixosModules.homeManager = { pkgs, ... }: {

    imports = [
      inputs.inputs.omniflake.flakes.home-manager.nixosModules.default
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    home-manager.backupFileExtension = "backup";

  };

}
