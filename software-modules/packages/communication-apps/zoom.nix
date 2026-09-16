{ self, inputs, ... }: {

  flake.nixosModules.zoom = { config, lib, pkgs, ... }: {

    options = {
      zoom.enable = lib.mkEnableOption "Enable Zoom";
    };

    config = lib.mkIf config.zoom.enable {
      environment.systemPackages = [ pkgs.zoom-us ];
    };

  };

}