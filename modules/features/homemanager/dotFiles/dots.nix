{ self, inputs, ... }: {

  flake.homeModules.dotFiles = { config, pkgs, lib, ... }: {

    imports = [
      self.homeModules.niriConfig
      self.homeModules.hyprlandConfig
    ];

  };

  flake.homeModules.niriConfig = { config, pkgs, lib, ... }: {

    imports = [
      self.homeModules.kittyConfig
      self.homeModules.noctaliaConfig
    ];

    options = {
      niriConfig.enable = lib.mkEnableOption "Niri Configuration";
    };

    config = lib.mkIf config.niriConfig.enable {

      kittyConfig.enable = lib.mkDefault true;
      noctaliaConfig.enable = lib.mkDefault true;

      xdg.configFile."niri" = {
        source = ./niri;
        recursive = true;
      };

    };

  };

  flake.homeModules.hyprlandConfig = { pkgs, lib, config, ... }: {

    imports = [
      self.homeModules.kittyConfig
      self.homeModules.noctaliaConfig
    ];

    options = {
      hyprlandConfig.enable = lib.mkEnableOption "Hyprland Configuration";
    };

    config = lib.mkIf config.hyprlandConfig.enable {

      kittyConfig.enable = lib.mkOverride 1001 true;
      noctaliaConfig.enable = lib.mkOverride 1001 true;

      xdg.configFile."hypr" = {
        source = ./hypr;
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
        source = ./noctalia;
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
        source = ./kitty;
        recursive = true;
      };

    };

  };

}
