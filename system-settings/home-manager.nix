{ self, inputs, ... }: {

  flake.nixosModules.home-manager = { pkgs, ... }: {

    imports = [
      inputs.omniflake.flakes.home-manager.nixosModules.default
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    home-manager.backupFileExtension = "backup";

  };

}
