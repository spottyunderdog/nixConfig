{ self, inputs, ... }: {

  flake.homeModules.zed = { config, pkgs, lib, ... }: {

    options = {
      zedConfig.enable = lib.mkEnableOption "zed-editor config";
    };

    config = lib.mkIf config.zedConfig.enable {

      programs.zed-editor = {
        enable = true;
        mutableUserSettings = true;
        extensions = [ "nix" "toml" "java" "lua" "latex" "catppuccin" "dracula" "catppuccin icons" ];
        userSettings = {
          show_whitespaces = "all";
          base_keymap = "VSCode";
          hour_format = "hour24";
          vim_mode = false;
          icon_theme = "Catppuccin Mocha";
          theme = {
            mode = "dark";
            dark = "Dracula";
            light = "Ayu Mirage";
          };

        };

      };

    };

  };

}
