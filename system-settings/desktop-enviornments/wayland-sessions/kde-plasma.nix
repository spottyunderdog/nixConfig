{ self, inputs, ...}: {

  flake.nixosModules.kde-plasma = { config, pkgs, lib, ... }: {

    options = {
      kde-plasma.enable = lib.mkEnableOption "Enable the KDE Plasma Desktop Environment.";
    };

    config = lib.mkIf config.kde-plasma.enable {

      services.desktopManager.plasma6.enable = true;
      services.desktopManager.plasma6.enableQt5Integration = true;

      services.displayManager.defaultSession = lib.mkOverride 900 "plasma";
      
      environment.systemPackages = with pkgs; [
        kdePackages.plasma-thunderbolt
        kdePackages.sddm-kcm
        kdePackages.oxygen
        kdePackages.oxygen-icons
        kdePackages.oxygen-sounds
      ];
      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        kwallet
        kwallet-pam
        kwalletmanager
      ] ++ lib.optional config.kate.enable kate
        ++ lib.optional config.filelight.enable filelight
        ++ lib.optional config.kcalc.enable kcalc
        ++ lib.optional config.dolphin.enable dolphin
        ++ lib.optional config.dolphin.enable qtsvg
        ++ lib.optional config.dolphin.enable kio 
        ++ lib.optional config.dolphin.enable kio-fuse
        ++ lib.optional config.dolphin.enable kio-extras;

    };

  };

}