{ self, inputs, ... }: {

  flake.homeModules.bash = { pkgs, config, lib, ... }: {

    options = {
      bash-config.enable = lib.mkEnableOption "Bash User Configs";
    };

    config = lib.mkIf config.bash-config.enable {
      programs.bash = {
        enable = true;
        historySize = 20000;
      };
    };

  };

}