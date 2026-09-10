{ self, inputs, ... }: {

  flake.nixosModules.displayManager = { pkgs, config, lib, ... }: {

    imports = [
      inputs.omniflake.flakes.silentsddm.nixosModules.default
      self.nixosModules.sddm
    ];

    services.displayManager.defaultSession = lib.mkForce "plasma";
    services.displayManager.sddm.enable = lib.mkOverride 1000 true;

    programs.silentSDDM = {
      enable = true;
      theme = "rei";
    };

  };

}
