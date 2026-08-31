{self, inputs, ...}: {

  flake.nixosModules.hyprland = { config, pkgs, lib, ... }: {

    options = {
      hyprland.enable = lib.mkEnableOption "Enable the Hyprland Desktop Environment.";
    };

    config = lib.mkIf config.hyprland.enable {

      # nix.settings = {
      #   extra-substituters = [ "https://noctalia.cachix.org" ];
      #   extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
      # };

      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
      };

      programs.noctalia = {
        enable = true;
        recommendedServices.enable = true;
      };

      environment.systemPackages = with pkgs; [
        evtest
        #smartctl
      ];

    };

  };

}
