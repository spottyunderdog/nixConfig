{ self, inputs, ... }: {
  flake.homeModules.bash = { config, lib, ... }: {

    options = {
      bash-config.enable = lib.mkEnableOption "Bash Configs";
    };

    config = lib.mkIf config.bash-config.enable {
      programs.bash = {
        enable = true;
        enableCompletion = true;

        historySize = 20000;

        initExtra = "fastfetch";

        shellAliases = config.var.shell-alias;

      };

    };

  };
 }