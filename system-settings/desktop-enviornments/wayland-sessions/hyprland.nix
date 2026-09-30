{self, inputs, ...}: {

  flake.nixosModules.hyprland = { config, pkgs, lib, ... }: {

    options = {
      hyprland.enable = lib.mkEnableOption "Enable the Hyprland Desktop Environment.";
      hyprland.useLatestGit = lib.mkEnableOption "Use the latest git verision of hyprland";
    };

    config = lib.mkIf config.hyprland.enable {

      services.displayManager.defaultSession = lib.mkOverride 960 "hyprland";

      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
        package = if config.hyprland.useLatestGit then inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland else pkgs.hyprland;
        portalPackage = if config.hyprland.useLatestGit then inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland else pkgs.xdg-desktop-portal-hyprland;
      };

      # xdg.portal = {
      #   enable = true;
      #   extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      # };

      kitty.enable = lib.mkOverride 991 true;
      zen.enable = lib.mkOverride 991 true;
      kate.enable = lib.mkOverride 991 true;
      kcalc.enable = lib.mkOverride 991 true;

      noctalia-shell.enable = lib.mkOverride 991 true;

      environment.systemPackages = with pkgs; [
        hyprmon
        bibata-cursors
      ];

    };

  };

}
