{ self, inputs, ... }: {

  flake.nixosModules.extraApps = { config, pkgs, lib, ... }: {

    imports = [
       self.nixosModules.shells
       self.nixosModules.extraCosmetics
       self.nixosModules.protonApps
       self.nixosModules.extraBrowsers
    ];

    extraShells.enable = lib.mkDefault false;

    extraCosmetics.enable = lib.mkDefault false;
    millennium.enable = lib.mkDefault false;
    vesktop.enable = lib.mkDefault false;

    protonApps.enable = lib.mkDefault false;

    zen.enable = lib.mkDefault false;
    vivaldi.enable = lib.mkDefault false;

  };

}
