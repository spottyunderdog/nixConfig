{ self, inputs, ... }: {

  flake.nixosModules.locale = { config, lib, ... }: {

    options = {
      nix-vars.locale = lib.mkOption {
        type = lib.types.str;
        default = "en_US.UTF-8";
      };
      
    };

  };

}