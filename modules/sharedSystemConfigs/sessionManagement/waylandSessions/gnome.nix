{self, inputs, ...}: {

  flake.nixosModules.gnome = { config, pkgs, lib, ... }: {

    options = {
      gnome.enable = lib.mkEnableOption "Enable the GNOME Desktop Environment.";
    };

    config = lib.mkIf config.gnome.enable {
      services.displayManager.gdm.enable = true;
      services.displayManager.sddm.enable = lib.mkForce false;
      services.desktopManager.gnome.enable = true;
      services.gnome.games.enable = false;

      environment.systemPackages = with pkgs; [
        gnome-tweaks
        gnome-extension-manager
        gnomeExtensions.paperwm
        gnomeExtensions.freon
        gnomeExtensions.caffeine
        gnomeExtensions.wiggle
        gnomeExtensions.pip-on-top
        adwaita-icon-theme
      ];

    };

  };

}
