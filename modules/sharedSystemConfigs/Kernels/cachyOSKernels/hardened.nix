{ self, inputs, ... }: {

  flake.nixosModules.cachyHardened = { pkgs, config, lib, ... }: {

    options = {
      cachyHardenedKernel.enable = lib.mkEnableOption "Enable CachyOS Hardened Kernel";
    };

    config = lib.mkIf config.cachyHardenedKernel.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-hardened;
    };

  };

}
