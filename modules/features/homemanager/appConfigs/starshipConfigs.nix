{ self, inputs, ... }: {

  flake.homeModules.starship = { config, pkgs, lib, ... }: {

    options = {
      starshipConfig.enable = lib.mkEnableOption "Starship Configuration, used for prompts";
    };

    config = lib.mkIf config.starshipConfig.enable {
      programs.starship = {
        enable = true;
        
        enableBashIntegration = lib.mkIf config.bashConfig.enable true;
        enableFishIntegration = lib.mkIf config.fishConfig.enable true;
        enableZshIntegration = lib.mkIf config.zshConfig.enable true;

        presets = [ "pastel-powerline" ];
      };

    };

  };

}