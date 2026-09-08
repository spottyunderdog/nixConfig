{ self, inputs, ... }: {

  flake.nixosModules.cachyLts = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.cachyLts-x86v3
      self.nixosModules.cachyLts-x86v4
      self.nixosModules.cachyLts-zen4
    ];

    options = {
      cachyLtsKernel.enable = lib.mkEnableOption "Enable Cachos LTS Kernel";
    };

    config = lib.mkIf config.cachyLtsKernel.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts;
    };

  };

}
