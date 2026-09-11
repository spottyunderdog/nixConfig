{ self, inputs, ... }: {

  flake.homeModules.kitty-dots = { pkgs, lib, config, ... } : {

    options = {
      kitty-dots.enable = lib.mkEnableOption "Kitty Configurations";
    };

    config = lib.mkIf config.kitty-dots.enable {

      xdg.configFile."kitty" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/nixConfig/dot-files/kitty";
        recursive = true;
      };

    };

  };

}