{ self, inputs, ... }: {

  flake.nixosModules.extra-packages = { config, pkgs, lib, ... }: {

    imports = [
       self.nixosModules.proton-packages
    ];

    proton-packages.enable = lib.mkDefault false;

  };

}
