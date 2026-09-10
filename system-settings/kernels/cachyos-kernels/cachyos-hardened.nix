{ self, inputs, ... }: {

  flake.nixosModules.cachyos-hardened = { pkgs, config, lib, ... }: {

    options = {
      cachyos-hardened-kernel.enable = lib.mkEnableOption "Enable CachyOS Hardened Kernel";
    };

    config = lib.mkIf config.cachyos-hardened-kernel.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-hardened;
    };

  };

}
