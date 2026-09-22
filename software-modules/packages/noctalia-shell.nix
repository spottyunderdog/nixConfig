{ self, inputs, ... }: {

  flake.nixosModules.noctalia-shell = { config, lib, pkgs, ... }: {

    options = {
      noctalia-shell.enable = lib.mkEnableOption "Enable Noctalia Shell";
    };

    config = lib.mkIf config.noctalia-shell.enable {
      
      bluetooth.enable = lib.mkOverride 990 true;
      networkmanager.enable = lib.mkOverride 990 true;
      services.power-profiles-daemon.enable = lib.mkDefault true;
      services.upower.enable = lib.mkDefault true;

      environment.systemPackages = with pkgs; [
        noctalia
        nwg-look
        kdePackages.qt6ct
      ];

    };

  };

}