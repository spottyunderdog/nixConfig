{ self, inputs, ... }: {

  flake.nixosModules.cachyLatest-x86v3 = { pkgs, config, lib, ... }: {

    options = {
      cachyLatestKernel-x86v3.enable = lib.mkEnableOption "Enables Latest CachyOS Kernel";
    };

    config = lib.mkIf config.cachyLatestKernel-x86v3.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
    };

  };

}
