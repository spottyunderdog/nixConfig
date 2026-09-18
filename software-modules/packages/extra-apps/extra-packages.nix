{ self, inputs, ... }: {

  flake.nixosModules.extra-packages = { config, pkgs, lib, ... }: {

    imports = [
       self.nixosModules.shells
       self.nixosModules.proton-packages
    ];

    extra-shells.enable = lib.mkDefault false;

    proton-packages.enable = lib.mkDefault false;

  };

}
