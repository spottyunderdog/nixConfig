{ self, inputs, ... }: {

  flake.nixosModules.time-zone = { lib, config, ... }: {

    options = {
      nix-vars.time-zone = lib.mkOption {
        type = lib.types.str;
        default = "America/New_York";
      };
    };

  };

}