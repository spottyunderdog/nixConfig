{ self, inputs, ... }: {

  flake.nixosModules.cachyLatest = { pkgs, config, lib, ... }: {
    
    imports = [
      # Architecture Specific Kernel Verions.
      self.nixosModules.cachyLatest-x86v3
      self.nixosModules.cachyLatest-x86v4
      self.nixosModules.cachyLatest-zen4
    ];
    
    options = {
      cachyLatestKernel.enable = lib.mkEnableOption "Enables Latest CachyOS Kernel";
    };
    
    config = lib.mkIf config.cachyLatestKernel.enable {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    };

  };

}
