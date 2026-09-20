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

      kitty.enable = lib.mkOverride 990 true;
      zen.enable = lib.mkOverride 990 true;
      kate.enable = lib.mkOverride 990 true;
      kcalc.enable = lib.mkOverride 990 true;

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
