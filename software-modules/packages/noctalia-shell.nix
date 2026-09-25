{ self, inputs, ... }: {

  flake.nixosModules.noctalia-shell = { config, lib, pkgs, ... }: {

    imports = [
      inputs.noctalia.nixosModules.default
    ];

    options = {
      noctalia-shell.enable = lib.mkEnableOption "Enable Noctalia Shell";
    };

    config = lib.mkIf config.noctalia-shell.enable {
      
      # bluetooth.enable = lib.mkOverride 990 true;
      # networkmanager.enable = lib.mkOverride 990 true;
      # services.power-profiles-daemon.enable = lib.mkDefault true;
      # services.upower.enable = lib.mkDefault true;

      programs.noctalia = {
        enable = true;
        # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
        recommendedServices.enable = true;
      };

      environment.systemPackages = with pkgs; [
        # noctalia
        nwg-look
        kdePackages.qt6ct
      ];

    };

  };

}