{ self, inputs, ... }: {

  flake.nixosModules.silentSDDM = {pkgs, config, lib, ... }: {

    imports = [
      inputs.omniflake.flakes.silentsddm.nixosModules.default
    ];

    options = {
      silentSDDM.enable = lib.mkEnableOption "Silent SDDM Theme";
      silentSDDM.theme = lib.mkOption {
        type = lib.types.str;
        default = "rei";
      };
    };

    config = lib.mkIf (config.sddm.enable && config.silentSDDM.enable) {
      services.displayManager.sddm.theme = "silent";
      programs.silentSDDM = {
        enable = true;
        theme = "rei";
      };

    };

  };

}