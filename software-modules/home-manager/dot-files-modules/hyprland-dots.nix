{ self, inputs, ... }: {

  flake.homeModules.hyprland-dots = { pkgs, lib, config, ... }: {

    options = {
      hyprland-dots.enable = lib.mkEnableOption "Hyprland Configuration";
    };

    config = lib.mkIf config.hyprland-dots.enable {

      kitty-dots.enable = lib.mkDefault true;
      noctalia-dots.enable = lib.mkDefault true;

      xdg.configFile."hypr" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/nixConfig/dot-files/hypr";
        recursive = true;
      };

      xdg.configFile."uwsm" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/nixConfig/dot-files/uwsm";
        recursive = true;
      };

    };

  };

}