{self, inputs, ...}: {

  flake.nixosModules.niri = { config, pkgs, lib, ... }: {

    options = {
      niri.enable = lib.mkEnableOption "Enable the Niri Desktop Environment.";
    };

    config = lib.mkIf config.niri.enable {

      programs.niri.enable = true;

      services.displayManager.defaultSession = lib.mkOverride 950 "niri";

      kitty.enable = lib.mkOverride 990 true;
      zen.enable = lib.mkOverride 990 true;
      kate.enable = lib.mkOverride 990 true;
      kcalc.enable = lib.mkOverride 990 true;

      bluetooth.enable = lib.mkOverride 990 true;
      networkmanager.enable = lib.mkOverride 990 true;
      services.power-profiles-daemon.enable = lib.mkOverride 990 true;
      services.upower.enable = lib.mkOverride 990 true;

      environment.systemPackages = with pkgs; [
        noctalia
        xwayland-satellite
      ];

    };

  };

}
