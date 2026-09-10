{ self, inputs, ... }: {

  flake.nixosModules.cachyos-latest-x86v3 = { pkgs, config, lib, ... }: {

    options = {
      cachyos-latest-kernel-x86v3.enable = lib.mkEnableOption "Enables Latest CachyOS Kernel";
    };

    config = lib.mkIf config.cachyos-latest-kernel-x86v3.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
    };

  };

}
