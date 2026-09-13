{ self, inputs, ... }: {

  flake.nixosModules.zram = { lib, config, ... }: {

    options = {
      zram.enable = lib.mkEnableOption "Use Zram";
    };

    config = lib.mkIf config.zram.enable {

      zramSwap = {
        enable = true;
        algorithm = "zstd";
        memoryPercent = 25;
      };

      systemd.oomd.enable = true;

    };

  };

}