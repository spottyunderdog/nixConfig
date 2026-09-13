{ self, inputs, ... } : {

  flake.nixosModules.allowed-ssh-users = { lib, ... } : {

    options = {
      nix-vars.allowed-ssh-users = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };

    };

  };

}