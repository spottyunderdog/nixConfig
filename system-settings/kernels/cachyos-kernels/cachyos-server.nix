{ self, inputs, ... }: {

  flake.nixosModules.cachyos-server = { pkgs, config, lib, ... }: {

    options = {
      cachyos-server-kernel.enable = lib.mkEnableOption "Enable CachyOS's Server Kernel";
    };

    config = lib.mkIf config.cachyos-server-kernel.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-server;
    };

  };

}
