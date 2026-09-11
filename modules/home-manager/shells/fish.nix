{ self, inputs, ... }: {

  flake.homeModules.fish = { config, lib, ... }: {

    options = {
      fish-config.enable = lib.mkEnableOption "Fish Configs";
    };

    config = lib.mkIf config.fish-config.enable {

      programs.fish = {
        enable = true;
        generateCompletions = true;
        interactiveShellInit = "fastfetch";

        shellAliases = config.var.shell-alias;
      };

    };

  };

 }