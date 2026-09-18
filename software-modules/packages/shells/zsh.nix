{ self, inputs, ... }: {

  flake.nixosModules.zsh = { config, lib, pkgs, ... }: {

    options = {
      zsh.enable = lib.mkEnableOption "ZSH Shell";
    };

    config = lib.mkIf config.zsh.enable {

      programs.zsh = {

        enable = true;
        autosuggestions = {
          enable = true;
          strategy = [ "history" ];
        };

        histSize = 20000;

        shellAliases = config.nix-vars.shell-alias;

        shellInit = "fastfetch";

      };


    };

  };

}