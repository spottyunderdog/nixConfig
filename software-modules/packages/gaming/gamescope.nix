{ self, inputs, ... }: {

  flake.nixosModules.gamescope = { config, lib, pkgs, ... }: {

    options = {
      gamescope.enable = lib.mkEnableOption "Enable Gamescope";
    };

    config = lib.mkIf config.gamescope.enable {

      programs.gamescope = {
        enable = true;
        enableWsi = true; # Can only be enabled in The Unstable Branches
      };

    };

  };

}