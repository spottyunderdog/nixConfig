{ self, inputs, ... }: {

  flake.nixosModules.zram = { lib, config, ... }: {

    options = {
      zram.enable = lib.mkEnableOption "Use Zram";
    };

    config = lib.mkIf config.zram.enable {

      zswap.enable = lib.mkForce false;

      zramSwap = {
        enable = true;
        algorithm = "zstd";
        memoryPercent = 25;
      };

      systemd.oomd.enable = true;

    };

  };

}