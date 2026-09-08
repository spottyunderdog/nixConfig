{ self, inputs, ... }: {

  flake.nixosModules.linuxKernels = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.linuxKernel6_12
      self.nixosModules.linuxKernel6_18
      self.nixosModules.linuxKernelLatest
      self.nixosModules.linuxNixDefault
    ];

    linuxKernelNixDefault.enable = lib.mkDefault false;
    linuxLatestKernel.enable = lib.mkDefault false;
    linuxKernel6_12.enable = lib.mkDefault false;
    linuxKernel6_18.enable = lib.mkDefault false;

  };

}