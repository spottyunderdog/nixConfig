{ self, inputs, ... }: {

  flake.nixosModules.comsApps = { config, pkgs, lib, ... }: {

    options = {
      comsApps.enable = lib.mkEnableOption "comsApps";
    };

    config = lib.mkIf config.comsApps.enable {

      environment.systemPackages = with pkgs; [
        whatsapp-electron
        zoom-us
      ] ++ lib.optional (!config.vesktop.enable) discord;

    };

  };
  
}