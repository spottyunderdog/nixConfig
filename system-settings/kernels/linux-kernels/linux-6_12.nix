{ self, inputs, ... }: {

  flake.nixosModules.linux-6_12 = { pkgs, config, lib, ... }: {

    options ={
      linux-kernel-6_12.enable = lib.mkEnableOption "Enables The latest linux kernel";
    };

    config = lib.mkIf config.linux-kernel-6_12.enable {
      boot.kernelPackages = pkgs.linuxPackages_6_12;
    };

  };

}
