{ self, inputs, ... }: {

  flake.nixosModules.coms-packages = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.zoom
      self.nixosModules.discord
    ];

    options = {
      coms-packages.enable = lib.mkEnableOption "comsApps";
    };

    config = lib.mkIf config.coms-packages.enable {
      
      zoom.enable = lib.mkDefault true;
      discord.enable = lib.mkDefault true;
      vesktop.enable = lib.mkDefault false;

    };

  };
  
}