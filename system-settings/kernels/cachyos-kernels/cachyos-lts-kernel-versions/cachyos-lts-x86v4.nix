{ self, inputs, ... }: {

  flake.nixosModules.cachyos-lts-x86v4 = { pkgs, config, lib, ... }: {

    options = {
      cachyos-lts-kernel-x86v4.enable = lib.mkEnableOption "Enable Cachos LTS Kernel";
    };

    config = lib.mkIf config.cachyos-lts-kernel-x86v4.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts-x86_64-v4;
    };

  };

}
