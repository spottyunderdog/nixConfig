{ self, inputs, ... }: {

  flake.homeModules.gtk-config = { config, lib, pkgs, ... }: {

      gtk = {
        enable = true;

        theme = {
          name = "adw-gtk3";
          package = pkgs.adw-gtk3;
        };

        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };

      };
      
      xdg.configFile."gtk-3.0/settings.ini".force = true;
      xdg.configFile."gtk-4.0/settings.ini".force = true;


  };

}