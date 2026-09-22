{ self, inputs, ... }: {

  flake.homeModules.hyprland-dots = { pkgs, lib, config, osConfig, ... }: {

    options = {
      hyprland-dots.enable = lib.mkEnableOption "Hyprland Configuration";
    };

    config = lib.mkIf config.hyprland-dots.enable {

      kitty-dots.enable = lib.mkDefault true;
      noctalia-dots.enable = lib.mkDefault true;

      xdg.configFile."hypr" = {
        source = config.lib.file.mkOutOfStoreSymlink
          #"${osConfig.nix-vars.install-dir}/nixConfig/dot-files/hypr";
          #"../../../dot-files/hypr";
          "${config.home.homeDirectory}/nixConfig/dot-files/hypr";
        recursive = true;
      };

      xdg.configFile."uwsm" = {
        source = config.lib.file.mkOutOfStoreSymlink
          #"${osConfig.nix-vars.install-dir}/nixConfig/dot-files/uwsm";
          #"../../../dot-files/uwsm";
          "${config.home.homeDirectory}/nixConfig/dot-files/uwsm";
        recursive = true;
      };

      gtk = {
        enable = true;
        theme = {
          name = "adw-gtk3";
          package = pkgs.adw-gtk3;
        };
      };

    };

  };

}