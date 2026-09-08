{self, inputs, ...}: {

  flake.nixosModules.wayland = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.kdePlasma
      self.nixosModules.gnome
      self.nixosModules.niri
      self.nixosModules.hyprland
    ];

    niri.enable = lib.mkDefault false;
    gnome.enable = lib.mkDefault false;
    hyprland.enable = lib.mkDefault false;
    kdePlasma.enable = lib.mkDefault true;

  };

}
