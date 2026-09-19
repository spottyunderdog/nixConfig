{ self, inputs, ... }: {

  flake.nixosModules.default-user = { config, lib, ... }: {

    options = {
      nix-vars.default-user = lib.mkOption {
        type = lib.types.str;
        default = "nix";
      };
      nix-vars.default-user-path = lib.mkOption {
        type = lib.types.path;
        default = "/home/${config.nix-vars.default-user}";
      };

    };

  };

}