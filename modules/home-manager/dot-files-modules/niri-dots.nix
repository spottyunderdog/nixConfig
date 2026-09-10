{ self, inputs, ... }: {

  flake.homeModules.niri-dots = { config, pkgs, lib, ... }: {

    options = {
      niriConfig.enable = lib.mkEnableOption "Niri Configuration";
    };

    config = lib.mkIf config.niriConfig.enable {

      kittyConfig.enable = lib.mkDefault true;
      noctaliaConfig.enable = lib.mkDefault true;

      xdg.configFile."niri" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/nixConfig/dotFiles/niri";
        recursive = true;
      };

    };

  };

}