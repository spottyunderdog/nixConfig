{ self, inputs, ... }: {

  flake.nixosModules.packages = { pkgs, lib, config, ... }: {

    imports = [
      self.nixosModules.dev-packages
      self.nixosModules.gamingApps
      self.nixosModules.mediaApps
      self.nixosModules.neededApps
      self.nixosModules.remoteAccessApps
      self.nixosModules.utilityApps
      self.nixosModules.extraApps
      self.nixosModules.editingApps
      self.nixosModules.flatpak
      self.nixosModules.coms-packages
      self.nixosModules.officeSuites
    ];

    dev-packages.enable = lib.mkDefault false;
    gamingApps.enable = lib.mkDefault false;
    mediaApps.enable = lib.mkDefault false;
    neededApps.enable = lib.mkDefault true;
    remoteAccessApps.enable = lib.mkDefault false;
    utilityApps.enable = lib.mkDefault true;
    editingApps.enable = lib.mkDefault false;
    coms-packages.enable = lib.mkDefault false;
    flatpak.enable = lib.mkDefault false;

  };

}
