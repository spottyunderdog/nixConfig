{self, inputs, ...}: {

  flake.nixosModules.hyprland = { config, pkgs, lib, ... }: {

    options = {
      hyprland.enable = lib.mkEnableOption "Enable the Hyprland Desktop Environment.";
    };

    config = lib.mkIf config.hyprland.enable {

      services.displayManager.defaultSession = lib.mkOverride 960 "hyprland";

      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
      };

      kitty.enable = lib.mkOverride 991 true;
      zen.enable = lib.mkOverride 991 true;
      kate.enable = lib.mkOverride 991 true;
      kcalc.enable = lib.mkOverride 991 true;

      bluetooth.enable = lib.mkOverride 991 true;
      networkmanager.enable = lib.mkOverride 991 true;

      services.power-profiles-daemon.enable = lib.mkDefault true;
      services.upower.enable = lib.mkDefault true;

      environment.systemPackages = with pkgs; [
        hyprmon
        bibata-cursors
        noctalia
      ];

    };

  };

}
