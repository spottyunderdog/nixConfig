{ self, inputs, ... }: {

  flake.homeModules.starship-config = { config, pkgs, lib, osConfig, ... }: {

    options = {
      starship-config.enable = lib.mkEnableOption "Starship Configuration, used for prompts";
    };

    config = lib.mkIf config.starship-config.enable {
      programs.starship = {
        enable = true;
        
        enableBashIntegration = lib.mkIf osConfig.bashPrompt.enableStarship true;
        enableFishIntegration = lib.mkIf osConfig.fish.enable true;
        enableZshIntegration = lib.mkIf osConfig.zsh.enable true;

        presets = [ "jetpack" ];
        settings = {
          cmd_duration = {
            min_time = 0;
            show_milliseconds = true;
            min_time_to_notify = 30000;
          };
        };
      };

    };

  };

}
