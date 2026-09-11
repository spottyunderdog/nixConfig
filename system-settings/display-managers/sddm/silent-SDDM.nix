{ self, inputs, ... }: {

  flake.nixosModules.silentSDDM = {pkgs, config, lib, ... }: {

    imports = [
      inputs.omniflake.flakes.silentsddm.nixosModules.default
    ];

    config = lib.mkIf config.sddm.enable {

      programs.silentSDDM = {
        enable = true;
        theme = "rei";
      };

    };

  };

}