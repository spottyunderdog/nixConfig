{ self, inputs, ... }: {

  flake.nixosModules.cachyos-latest-zen4 = { pkgs, config, lib, ... }: {

    options = {
      cachyos-latest-kernel-zen4.enable = lib.mkEnableOption "Enables Latest CachyOS Kernel";
    };

    config = lib.mkIf config.cachyos-latest-kernel-zen4.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
    };

  };

}
