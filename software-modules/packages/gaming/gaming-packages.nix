{ self, inputs, ... }: {

  flake.nixosModules.gaming-packages = { config, pkgs, lib, ... }: {
    
    imports = [
      self.nixosModules.gamemode
      self.nixosModules.gamescope
      self.nixosModules.goverlay
      self.nixosModules.heroic
      self.nixosModules.lutris
      self.nixosModules.mangohud
      self.nixosModules.prismlauncher
      self.nixosModules.protonplus
      self.nixosModules.protontricks
      self.nixosModules.r2modman
      self.nixosModules.steam
      self.nixosModules.umu-launcher
    ];

    options = {
      gaming-packages.enable = lib.mkEnableOption "gamingApps";
    };
    
    config = lib.mkIf config.gaming-packages.enable {
      
      gamemode.enable = lib.mkDefault true;
      gamescope.enable = lib.mkDefault true;
      goverlay.enable = lib.mkDefault true;
      heroic.enable = lib.mkDefault true;
      lutris.enable = lib.mkDefault true;
      mangohud.enable = lib.mkDefault true;
      prismlauncher.enable = lib.mkDefault true;
      protonplus.enable = lib.mkDefault true;
      protontricks.enable = lib.mkDefault true;
      r2modman.enable = lib.mkDefault true;
      steam.enable = lib.mkDefault true;
      millennium.enable = lib.mkDefault false;
      umu-launcher.enable = lib.mkDefault true;
      wine.enable = lib.mkOverride 1001 true;

    };

  };

}
