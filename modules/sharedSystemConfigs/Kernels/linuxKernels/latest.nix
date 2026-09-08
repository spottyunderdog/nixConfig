{ self, inputs, ... }: {

  flake.nixosModules.linuxKernelLatest = { pkgs, config, lib, ... }: {

    options ={
      linuxLatestKernel.enable = lib.mkEnableOption "Enables The latest linux kernel";
    };

    config = lib.mkIf config.linuxLatestKernel.enable {
      boot.kernelPackages = pkgs.linuxPackages_latest;
    };

  };

}
