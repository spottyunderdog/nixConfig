{ self, inputs, ... }: {

  flake.homeModules.starship-config = { config, pkgs, lib, osConfig, ... }: {

    options = {
      starship-config.enable = lib.mkEnableOption "Starship Configuration, used for prompts";
    };

    config = lib.mkIf config.starship-config.enable {
      programs.starship = {
        enable = true;
        
        enableBashIntegration = osConfig.bashPrompt.enableStarship;
        enableFishIntegration = osConfig.fish.enable;
        enableZshIntegration = osConfig.zsh.enable;

        presets = [ "pastel-powerline" ];
      };

    };

  };

}