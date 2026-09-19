{ self, inputs, ... }: {

  flake.nixosModules.ssh-ports = { lib, config, ... }: {

    options = {
      nix-vars.ssh-ports = lib.mkOption {
        type = lib.types.listOf lib.types.int;
        default = [ ];
      };
    };

  };

}