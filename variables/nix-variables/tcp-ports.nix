{ self, inputs, ... }: {

  flake.nixosModules.tcp-ports = { config, lib, ... }: {

    options = {
      nix-vars.allowedTcp = lib.mkOption {
        type = lib.types.listOf lib.types.int;
        default = [];
      };

      nix-vars.allowedTcpRanges = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {

          options = {
            from = lib.mkOption { type = lib.types.port; };
            to = lib.mkOption { type = lib.types.port; };
          };
        });
        default = [];
      };

    };

  };

}