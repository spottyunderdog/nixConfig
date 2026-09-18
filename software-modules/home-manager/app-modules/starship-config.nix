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

        presets = [ "pastel-powerline" ];
      };

    };

  };

}