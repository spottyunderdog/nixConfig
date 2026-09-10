{ self, inputs, ... }: {

  flake.nixosModules.cachyos-latest-x86v4 = { pkgs, config, lib, ... }: {

    options = {
      cachyos-latest-kernel-x86v4.enable = lib.mkEnableOption "Enables Latest CachyOS Kernel";
    };

    config = lib.mkIf config.cachyos-latest-kernel-x86v4.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v4;
    };

  };

}
