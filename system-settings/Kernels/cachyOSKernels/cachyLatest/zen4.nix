{ self, inputs, ... }: {

  flake.nixosModules.cachyLatest-zen4 = { pkgs, config, lib, ... }: {

    options = {
      cachyLatestKernel-zen4.enable = lib.mkEnableOption "Enables Latest CachyOS Kernel";
    };

    config = lib.mkIf config.cachyLatestKernel-zen4.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
    };

  };

}
