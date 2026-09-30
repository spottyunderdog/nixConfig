{ self, inputs, ... }: {

  flake.nixosModules.noctalia-shell = { config, lib, pkgs, ... }: {

    imports = [
      inputs.noctalia.nixosModules.default
    ];

    options = {
      noctalia-shell.enable = lib.mkEnableOption "Enable Noctalia Shell";
    };

    config = lib.mkIf config.noctalia-shell.enable {
      programs.noctalia = {
        enable = true;
        # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
        recommendedServices.enable = true;
      };

      environment.systemPackages = with pkgs; [
        nwg-look
        kdePackages.qt6ct
      ];

    };

  };

}