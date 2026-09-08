{ self, inputs, ... }: {

  flake.nixosModules.swap = { config, pkgs, lib, ... }: {

    options = {
      swap.enable = lib.mkEnableOption "Enable swap";
    };

    config = lib.mkIf config.swap.enable {
      swapDevices = [{
        device = "/var/lib/swapfile";
        size = 48*1024; # 48 GiB
      }];

      boot.zswap = {
        enable = true;
        acceptThresholdPercent = 90;
        compressor = "zstd";
        maxPoolPercent = 25;
        shrinkerEnabled = true;
      };
 
    };

  };

}
