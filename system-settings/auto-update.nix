{ self, inputs, ... }: {

  flake.nixosModules.auto-update = { lib, config, ... }: {

    options = {
      auto-update.enable = lib.mkEnableOption "Auto Update the Flake";
    };

  };

}