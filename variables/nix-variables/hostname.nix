{ self, inputs, ... }: {

  flake.nixosModules.hostname = { config, lib, ... }: {

    options = {
      nix-vars.hostname = lib.mkOption {
        type = lib.types.str;
        default = "host";
      };

    };

  };

}