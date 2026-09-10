{ self, inputs, ... }: {

  flake.nixosModules.linux-6_18 = { pkgs, config, lib, ... }: {

    options ={
      linux-kernel-6_18.enable = lib.mkEnableOption "Enables The latest linux kernel";
    };

    config = lib.mkIf config.linux-kernel-6_18.enable {
      boot.kernelPackages = pkgs.linuxPackages_6_18;
    };

  };

}
