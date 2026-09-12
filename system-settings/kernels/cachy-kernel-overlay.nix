{ self, inputs, ... }: {

  flake.nixosModules.cachyos-kernel-overlay = { config, lib, pkgs, ... }: {

    options = {

      cachyos-kernel-overlay.omniflakeEnable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      cachyos-kernel.overlay = lib.mkOption {
        type = lib.types.listOf (lib.types.raw);
        default = [ inputs.nix-cachyos-kernel.overlays.default ]; 
      };

    };

    config = lib.mkIf config.cachyos-kernel-overlay.omniflakeEnable {
      cachyos-kernel.overlay = [ inputs.omniflake.flakes.nix-cachyos-kernel.overlays.default ];
    };

  };

}