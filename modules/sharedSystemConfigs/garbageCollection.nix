{ self, inputs, ... } : {

  flake.nixosModules.autoGarbageCollection = { config, pkgs, lib, ... }: {

    options = {
      autoGarbageCollection.enable = lib.mkEnableOption "Enable the module";
    };

    config = lib.mkIf config.autoGarbageCollection.enable {
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 2d";
      };

    };

  };

}