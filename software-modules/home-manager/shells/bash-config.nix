{ self, inputs, ... }: {

  flake.homeModules.bash-config = { pkgs, config, lib, ... }: {

    options = {
      bash-config.enable = lib.mkEnableOption "Bash User Configs";
    };

    config = lib.mkIf config.bash-config.enable {
      programs.bash = {
        enable = lib.mkDefault true;
        historySize = 20000;
      };
    };

  };

}