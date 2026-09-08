{ self, inputs, ... }: {

  flake.nixosModules.cachyLts-x86v4 = { pkgs, config, lib, ... }: {

    options = {
      cachyLtsKernel-x86v4.enable = lib.mkEnableOption "Enable Cachos LTS Kernel";
    };

    config = lib.mkIf config.cachyLtsKernel-x86v4.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts-x86_64-v4;
    };

  };

}
