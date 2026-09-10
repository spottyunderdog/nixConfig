{ self, inputs, ... }: {

  flake.nixosModules.display-manager = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.sddm
    ];

    services.displayManager.defaultSession = lib.mkForce "plasma";
    services.displayManager.sddm.enable = lib.mkOverride 1000 true;



  };

}
