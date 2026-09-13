{ self, inputs, ... }: {

  flake.nixosModules.swap-size = { config, lib, }: {

    options = {
      nix-vars.swap-size = lib.mkOption {
        type = lib.types.inr;
        default = 32;
      };

    };

  };

}