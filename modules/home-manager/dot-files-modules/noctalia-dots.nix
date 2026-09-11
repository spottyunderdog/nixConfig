{ self, inputs, ... }: {

    flake.homeModules.noctalia-dots = { pkgs, lib, config, ... }: {

    options = {
      noctalia-dots.enable = lib.mkEnableOption "Noctalia Configurations";
    };

    config = lib.mkIf config.noctalia-dots.enable {

      xdg.configFile."noctalia" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/nixConfig/dot-files/noctalia";
        recursive = true;
      };

    };

  };

}