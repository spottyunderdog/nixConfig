{ self, inputs, ... }: {

  flake.homeModules.zed-editor-config = { config, pkgs, lib, ... }: {

    options = {
      zed-editor-config.enable = lib.mkEnableOption "zed-editor config";
    };

    config = lib.mkIf config.zed-editor-config.enable {

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
