{ self, inputs, ... }: {

  flake.nixosModules.display-manager = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.sddm
    ];

    sddm.enable = lib.mkDefault true;
    silentSDDM.enable = lib.mkDefault true;
    astronaut-theme.enable = lib.mkDefault false;

  };

}
