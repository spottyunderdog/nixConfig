{ self, inputs, ... }: {

  flake.nixosModules.linux-6_12 = { pkgs, config, lib, ... }: {

    options ={
      linux-6_12-kernel.enable = lib.mkEnableOption "Enables The latest linux kernel";
    };

    config = lib.mkIf config.linux-6_12-kernel.enable {
      boot.kernelPackages = pkgs.linuxPackages_6_12;
    };

  };

}
