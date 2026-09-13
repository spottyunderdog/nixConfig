{ self, inputs, ... }: {

  flake.nixosModules.zswap = { lib, config, ... }: {

    options = {
      zswap.enable = lib.mkEnableOption "Use Zswap";
    };

    config = lib.mkIf config.zswap.enable {
      swap.enable = lib.mkForce true;

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