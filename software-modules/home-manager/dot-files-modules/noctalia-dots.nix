{ self, inputs, ... }: {

    flake.homeModules.noctalia-dots = { pkgs, lib, config, osConfig, ... }: {

    options = {
      noctalia-dots.enable = lib.mkEnableOption "Noctalia Configurations";
    };

    config = lib.mkIf config.noctalia-dots.enable {

      xdg.configFile."noctalia" = {
        source = config.lib.file.mkOutOfStoreSymlink
          #"${osConfig.nix-vars.install-dir}/nixConfig/dot-files/noctalia";
          "${config.home.homeDirectory}/nixConfig/dot-files/noctalia";
          #../../../dot-files/noctalia;
        recursive = true;
      };

    };

  };

}