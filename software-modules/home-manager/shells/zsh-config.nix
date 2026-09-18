{ self, inputs, ... }: {

  flake.homeModules.zsh-config = { pkgs, config, lib, ... }: {

    options = {
      zsh-config.enable = lib.mkEnableOption "zsh User Configs";
    };

    config = lib.mkIf config.zsh-config.enable {
      programs.zsh = {
        enable = true;
        history = {
          share = true;
          size = 20000;
        };
      };
    };

  };

}