{ self, inputs, ... }: {

  flake.nixosModules.gamingApps = { config, pkgs, lib, ... }: {
    
    options = {
      gamingApps.enable = lib.mkEnableOption "gamingApps";
    };
    
    config = lib.mkIf config.gamingApps.enable {
      
      environment.systemPackages = with pkgs; [
        wine
        winetricks
        gamescope
        goverlay
        heroic
        lutris
        mangohud
        protontricks
        prismlauncher
        protonplus
        r2modman
        umu-launcher
      ] ++ lib.optional (!config.millennium.enable) steam;
      
    };

  };

}
