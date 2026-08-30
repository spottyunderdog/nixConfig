{ self, inputs, ... }: {

  flake.nixosModules.cachyLts-zen4 = { pkgs, config, lib, ... }: {

    options = {
      cachyLtsKernel-zen4.enable = lib.mkEnableOption "Enable Cachos LTS Kernel";
    };

    config = lib.mkIf config.cachyLtsKernel-zen4.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts-zen4;
    };

  };

}
