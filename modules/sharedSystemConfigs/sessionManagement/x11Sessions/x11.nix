{self, inputs, ...}: {

  flake.nixosModules.x11 = { config, pkgs, lib, ... }: {

    imports = [
      # If you have any other X11 session modules, you can import them here.
      self.nixosModules.xfce
    ];

    xfce.enable = lib.mkDefault false;

  };

}
