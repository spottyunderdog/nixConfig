{ self, inputs, ... }: {

  flake.homeModules.niri-dots = { config, pkgs, lib, ... }: {

    options = {
      niri-dots.enable = lib.mkEnableOption "Niri Configuration";
    };

    config = lib.mkIf config.niri-dots.enable {

      kitty-dots.enable = lib.mkDefault true;
      noctalia-dots.enable = lib.mkDefault true;

      xdg.configFile."niri" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/nixConfig/dot-files/niri";
        recursive = true;
      };

    };

  };

}