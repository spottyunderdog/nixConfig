{ self, inputs, ... }: {

  flake.homeModules.kitty-dots = { pkgs, lib, config, osConfig, ... } : {

    options = {
      kitty-dots.enable = lib.mkEnableOption "Kitty Configurations";
    };

    config = lib.mkIf config.kitty-dots.enable {

      xdg.configFile."kitty" = {
        source = config.lib.file.mkOutOfStoreSymlink
          #"${osConfig.nix-vars.install-dir}/nixConfig/dot-files/kitty";
          #../../../dot-files/kitty;
          "${config.home.homeDirectory}/nixConfig/dot-files/kitty";
        recursive = true;
      };

    };

  };

}