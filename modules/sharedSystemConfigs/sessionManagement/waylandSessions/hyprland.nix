{self, inputs, ...}: {

  flake.nixosModules.hyprland = { config, pkgs, lib, ... }: {

    options = {
      hyprland.enable = lib.mkEnableOption "Enable the Hyprland Desktop Environment.";
    };

    config = lib.mkIf config.hyprland.enable {

    };

  };

}
