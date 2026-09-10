{ self, inputs, ... }: {

  flake.nixosModules.linux-6_18 = { pkgs, config, lib, ... }: {

    options ={
      linux-6_18-kernel.enable = lib.mkEnableOption "Enables The latest linux kernel";
    };

    config = lib.mkIf config.linux-6_18-kernel.enable {
      boot.kernelPackages = pkgs.linuxPackages_6_18;
    };

  };

}
