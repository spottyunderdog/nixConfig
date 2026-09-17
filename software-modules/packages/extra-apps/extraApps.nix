{ self, inputs, ... }: {

  flake.nixosModules.extraApps = { config, pkgs, lib, ... }: {

    imports = [
       self.nixosModules.shells
       self.nixosModules.protonApps
    ];

    extraShells.enable = lib.mkDefault false;

    millennium.enable = lib.mkDefault false;

    protonApps.enable = lib.mkDefault false;

  };

}
