{ self, inputs, ...}: {

  flake.nixosModules.thunar = { config, pkgs, lib, ... }: {

    options = {
      thunar.enable = lib.mkEnableOption "Thunar File Manager";
    };

    config = lib.mkIf config.thunar.enable {

      programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-volman
          thunar-archive-plugin
          thunar-vcs-plugin
        ];
      };

      programs.xfconf.enable = true;
      services.gvfs.enable = true; # Mount, trash, and other functionalities
      services.tumbler.enable = true; # Thumbnail support for images

    };

  };
  
}