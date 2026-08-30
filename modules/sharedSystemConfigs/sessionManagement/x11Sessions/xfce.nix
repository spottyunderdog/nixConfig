{ self, inputs, ... }: {

  flake.nixosModules.xfce = { pkgs, config, lib, ... }: {

    options = {
      xfce.enable = lib.mkEnableOption "Enable the XFCE Desktop Environment.";
    };

    config = lib.mkIf config.xfce.enable {
      services.xserver.desktopManager.xfce.enable = true;
    };

  };

}
