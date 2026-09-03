{ self, inputs, ... }: {

  flake.homeModules.dotFiles = { config, pkgs, lib, ... }: {

    imports = [
      self.homeModules.niriConfig
      self.homeModules.hyprlandConfig
      self.homeModules.kittyConfig
      self.homeModules.noctaliaConfig
    ];

  };

  flake.homeModules.niriConfig = { config, pkgs, lib, ... }: {

    options = {
      niriConfig.enable = lib.mkEnableOption "Niri Configuration";
    };

    config = lib.mkIf config.niriConfig.enable {

      kittyConfig.enable = lib.mkDefault true;
      noctaliaConfig.enable = lib.mkDefault true;

      xdg.configFile."niri" = {
        source = config.lib.file.mkOutOfStoreSymlink ./niri;
        recursive = true;
      };

    };

  };

  flake.homeModules.hyprlandConfig = { pkgs, lib, config, ... }: {

    options = {
      hyprlandConfig.enable = lib.mkEnableOption "Hyprland Configuration";
    };

    config = lib.mkIf config.hyprlandConfig.enable {

      kittyConfig.enable = lib.mkDefault true;
      noctaliaConfig.enable = lib.mkDefault true;

      xdg.configFile."hypr" = {
        source = config.lib.file.mkOutOfStoreSymlink ./hypr;
        recursive = true;
      };

      xdg.configFile."uwsm" = {
        source = config.lib.file.mkOutOfStoreSymlink ./uwsm;
        recursive = true;
      };

    };

  };

  flake.homeModules.noctaliaConfig = { pkgs, lib, config, ... }: {

    options = {
      noctaliaConfig.enable = lib.mkEnableOption "Noctalia Configurations";
    };

    config = lib.mkIf config.noctaliaConfig.enable {

      xdg.configFile."noctalia" = {
        source = config.lib.file.mkOutOfStoreSymlink ./noctalia;
        recursive = true;
      };

    };

  };

  flake.homeModules.kittyConfig = { pkgs, lib, config, ... } : {

    options = {
      kittyConfig.enable = lib.mkEnableOption "Kitty Configurations";
    };

    config = lib.mkIf config.kittyConfig.enable {

      xdg.configFile."kitty" = {
        source = config.lib.file.mkOutOfStoreSymlink ./kitty;
        recursive = true;
      };

    };

  };

}
