{ self, inputs, ... }: {

  flake.nixosModules.swap = { config, pkgs, lib, ... }: {

    options = {
      swap.enable = lib.mkEnableOption "Enable swap";
    };

    config = lib.mkIf config.swap.enable {
      swapDevices = [{
        device = "/var/lib/swapfile";
        size = config.nix-vars.swap-size * 1024; # 48 GiB
      }];
 
    };

  };

}
