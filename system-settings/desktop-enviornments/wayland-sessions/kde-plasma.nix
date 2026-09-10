{ self, inputs, ...}: {

  flake.nixosModules.kde-plasma = { config, pkgs, lib, ... }: {

    options = {
      kde-plasma.enable = lib.mkEnableOption "Enable the KDE Plasma Desktop Environment.";
    };

    config = lib.mkIf config.kde-plasma.enable {
      services.desktopManager.plasma6.enable = true;
       environment.systemPackages = with pkgs; [
        kdePackages.plasma-thunderbolt
      ];
    };

  };

}