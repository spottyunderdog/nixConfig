{ self, inputs, ... }: {

  flake.nixosModules.cachyLatest-x86v4 = { pkgs, config, lib, ... }: {

    options = {
      cachyLatestKernel-x86v4.enable = lib.mkEnableOption "Enables Latest CachyOS Kernel";
    };

    config = lib.mkIf config.cachyLatestKernel-x86v4.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v4;
    };

  };

}
