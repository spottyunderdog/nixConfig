{ self, inputs, ... }: {

  flake.nixosModules.comsApps = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.zoom
      self.nixosModules.discord
    ];

    options = {
      comsApps.enable = lib.mkEnableOption "comsApps";
    };

    config = lib.mkIf config.comsApps.enable {
      
      zoom.enable = lib.mkDefault true;
      discord.enable = lib.mkDefault true;
      vesktop.enable = lib.mkDefault false;

    };

  };
  
}