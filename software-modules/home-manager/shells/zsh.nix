{ self, inputs, ... }: { 

  flake.homeModules.zsh = { pkgs, config, lib, ... }: {

    options = {
      zsh-config.enable = lib.mkEnableOption "Zsh Configs";
    };

    config = lib.mkIf config.zsh-config.enable {
      programs.zsh = {
        enable = true;
        autosuggestion = {
          enable = true;
          strategy = [ "history" ];
        };

        history = {
          share = true;
          size = 20000;
        };

        shellAliases = config.home-vars.shell-alias;

        initContent = "fastfetch";

      };

    };

  };

}