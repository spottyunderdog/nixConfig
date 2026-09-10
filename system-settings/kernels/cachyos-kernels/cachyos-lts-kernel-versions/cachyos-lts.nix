{ self, inputs, ... }: {

  flake.nixosModules.cachyos-lts = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.cachyos-lts-x86v3
      self.nixosModules.cachyos-lts-x86v4
      self.nixosModules.cachyos-lts-zen4
    ];

    options = {
      cachyos-lts-kernel.enable = lib.mkEnableOption "Enable Cachos LTS Kernel";
    };

    config = lib.mkIf config.cachyos-lts-kernel.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts;
    };

  };

}
