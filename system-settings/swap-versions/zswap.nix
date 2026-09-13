{ self, inputs, ... }: {

  flake.nixosModules.zwap = { lib, config, ... }: {

    options = {
      zswap.enable = lib.mkEnableOption "Use Zswap";
    };

    config = lib.mkIf config.zswap.enable {
      swap.enable = lib.mkForce true;
      zram.enable = lib.mkForce false;

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