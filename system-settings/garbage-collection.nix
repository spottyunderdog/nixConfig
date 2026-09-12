{ self, inputs, ... } : {

  flake.nixosModules.auto-garbage-collection = { config, pkgs, lib, ... }: {

    options = {
      auto-garbage-collection.enable = lib.mkEnableOption "Enable the module";
    };

    config = lib.mkIf config.auto-garbage-collection.enable {
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 5d";
      };

    };

  };

}