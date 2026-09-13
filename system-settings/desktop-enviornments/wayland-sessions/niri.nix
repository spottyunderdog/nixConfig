{self, inputs, ...}: {

  flake.nixosModules.niri = { config, pkgs, lib, ... }: {

   # imports = [
   #   inputs.noctalia.nixosModules.default
   # ];

    options = {
      niri.enable = lib.mkEnableOption "Enable the Niri Desktop Environment.";
    };

    config = lib.mkIf config.niri.enable {

      programs.niri.enable = true;

      services.displayManager.defaultSession = lib.mkOverride 950 "niri";

      #programs.noctalia = {
      #  enable = true;
      #  recommendedServices.enable = true;
      #};

      networking.networkmanager.enable = lib.mkDefault true;
      hardware.bluetooth.enable = lib.mkDefault true;
      services.power-profiles-daemon.enable = lib.mkDefault true;
      services.upower.enable = lib.mkDefault true;

      environment.systemPackages = with pkgs; [
        noctalia
        xwayland-satellite
      ];

    };

  };

}
