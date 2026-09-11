{ self, inputs, ... }: {

  flake.nixosModules.xfce = { pkgs, config, lib, ... }: {

    options = {
      xfce.enable = lib.mkEnableOption "Enable the XFCE Desktop Environment.";
    };

    config = lib.mkIf config.xfce.enable {
      services.displayManager.defaultSession = lib.mkOverride 970 "xfce";
      services.xserver.desktopManager.xfce.enable = true;
    };

  };

}
