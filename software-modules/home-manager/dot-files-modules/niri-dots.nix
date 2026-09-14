{ self, inputs, ... }: {

  flake.homeModules.niri-dots = { config, pkgs, lib, osConfig, ... }: {

    options = {
      niri-dots.enable = lib.mkEnableOption "Niri Configuration";
    };

    config = lib.mkIf config.niri-dots.enable {

      kitty-dots.enable = lib.mkDefault true;
      noctalia-dots.enable = lib.mkDefault true;

      xdg.configFile."niri" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${osConfig.nix-vars.install-dir}/nixConfig/dot-files/niri";
        recursive = true;
      };

    };

  };

}