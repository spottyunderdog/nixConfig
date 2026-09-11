{ self, inputs, ... }: {

  flake.homeModules.starship-config = { config, pkgs, lib, ... }: {

    options = {
      starship-config.enable = lib.mkEnableOption "Starship Configuration, used for prompts";
    };

    config = lib.mkIf config.starship-config.enable {
      programs.starship = {
        enable = true;
        
        enableBashIntegration = lib.mkIf config.bash-config.enable true;
        enableFishIntegration = lib.mkIf config.fish-config.enable true;
        enableZshIntegration = lib.mkIf config.zsh-config.enable true;

        presets = [ "pastel-powerline" ];
      };

    };

  };

}