{ self, inputs, ... }: {

  flake.nixosModules.install-dir = { config, lib, ...}: {

    options = {

      nix-vars.install-dir = lib.mkOption {
        type = lib.types.path;
        default = "/etc/nixos";
      };

    };

  };

}