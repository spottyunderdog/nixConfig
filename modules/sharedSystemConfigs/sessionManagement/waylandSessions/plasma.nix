{self, inputs, ...}: {

  flake.nixosModules.kdePlasma = { config, pkgs, lib, ... }: {

    options = {
      kdePlasma.enable = lib.mkEnableOption "Enable the KDE Plasma Desktop Environment.";
    };

    config = lib.mkIf config.kdePlasma.enable {
      services.desktopManager.plasma6.enable = true;
    };

  };

}