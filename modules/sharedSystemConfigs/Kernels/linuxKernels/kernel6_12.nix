{ self, inputs, ... }: {

  flake.nixosModules.linuxKernel6_12 = { pkgs, config, lib, ... }: {

    options ={
      linuxKernel6_12.enable = lib.mkEnableOption "Enables The latest linux kernel";
    };

    config = lib.mkIf config.linuxKernel6_12.enable {
      boot.kernelPackages = pkgs.linuxPackages_6_12;
    };

  };

}
