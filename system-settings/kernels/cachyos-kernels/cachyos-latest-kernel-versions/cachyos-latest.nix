{ self, inputs, ... }: {

  flake.nixosModules.cachyos-latest = { pkgs, config, lib, ... }: {
    
    imports = [
      # Architecture Specific Kernel Verions.
      self.nixosModules.cachyos-latest-x86v3
      self.nixosModules.cachyos-latest-x86v4
      self.nixosModules.cachyos-latest-zen4
    ];
    
    options = {
      cachyos-latest-kernel.enable = lib.mkEnableOption "Enables Latest CachyOS Kernel";
    };
    
    config = lib.mkIf config.cachyos-latest-kernel.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    };

  };

}
