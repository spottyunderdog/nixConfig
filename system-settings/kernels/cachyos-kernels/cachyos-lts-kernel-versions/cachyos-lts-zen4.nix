{ self, inputs, ... }: {

  flake.nixosModules.cachyos-lts-zen4 = { pkgs, config, lib, ... }: {

    options = {
      cachyos-lts-kernel-zen4.enable = lib.mkEnableOption "Enable Cachos LTS Kernel";
    };

    config = lib.mkIf config.cachyos-lts-kernel-zen4.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts-zen4;
    };

  };

}
