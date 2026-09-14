{ self, inputs, ... }: {

  flake.nixosModules.udp-ports = { config, lib, ... }: {

    options = {
      nix-vars.allowedUdp = lib.mkOption {
        type = lib.types.listOf lib.types.int;
        default = [];
      };

      nix-vars.allowedUdpRanges = lib.mkOption {
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