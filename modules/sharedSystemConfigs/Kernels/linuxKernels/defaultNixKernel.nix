{ self, inputs, ... }: {

  flake.nixosModules.linuxNixDefault = { pkgs, config, lib, ... }: {
 
    options ={
      linuxKernelNixDefault.enable = lib.mkEnableOption "Enables The latest linux kernel";
    };

    config = lib.mkIf config.linuxKernelNixDefault.enable {
      boot.kernelPackages = pkgs.linuxPackages;
    };

  };

}