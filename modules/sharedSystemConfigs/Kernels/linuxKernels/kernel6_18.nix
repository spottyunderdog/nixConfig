{ self, inputs, ... }: {

  flake.nixosModules.linuxKernel6_18 = { pkgs, config, lib, ... }: {

    options ={
      linuxKernel6_18.enable = lib.mkEnableOption "Enables The latest linux kernel";
    };

    config = lib.mkIf config.linuxKernel6_18.enable {
      boot.kernelPackages = pkgs.linuxPackages_6_18;
    };

  };

}
