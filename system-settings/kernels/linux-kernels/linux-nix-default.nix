{ self, inputs, ... }: {

  flake.nixosModules.linux-nix-default = { pkgs, config, lib, ... }: {
 
    options ={
      linux-nix-default-kernel.enable = lib.mkEnableOption "Enables The latest linux kernel";
    };

    config = lib.mkIf config.linux-nix-default-kernel.enable {
      boot.kernelPackages = pkgs.linuxPackages;
    };

  };

}