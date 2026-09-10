{ self, inputs, ... }: {

  flake.nixosModules.cachyServer = { pkgs, config, lib, ... }: {

    options = {
      cachyServerKernel.enable = lib.mkEnableOption "Enable CachyOS's Server Kernel";
    };

    config = lib.mkIf config.cachyServerKernel.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-server;

    };

  };

}
