{ self, inputs, ... }: {

  flake.nixosModules.linux-latest = { pkgs, config, lib, ... }: {

    options ={
      linux-latest-kernel.enable = lib.mkEnableOption "Enables The latest linux kernel";
    };

    config = lib.mkIf config.linux-latest-kernel.enable {
      boot.kernelPackages = pkgs.linuxPackages_latest;
    };

  };

}
