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

        font = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Medium";
          size = 10;
        };

      };
      
      xdg.configFile."gtk-3.0/settings.ini".force = true;
      xdg.configFile."gtk-4.0/settings.ini".force = true;
      home.file."${config.home.homeDirectory}/.gtkrc-2.0".force = lib.mkForce true;

  };

}