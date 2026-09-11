{ self, inputs, ... }: {

  flake.nixosModules.display-manager = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.sddm
    ];

    services.displayManager.defaultSession = lib.mkDefault "plasma";

  };

}
