{ self, inputs, ... }: {

  flake.nixosModules.amd-drivers = { pkgs, config, lib, ... }: {

    options = {
        amd-drivers.enable = lib.mkEnableOption "AMD drivers";
    };

    config = lib.mkIf config.amd-drivers.enable {
      services.xserver.videoDrivers = [ "amdgpu" ];
      boot.initrd.kernelModules = [ "amdgpu" ];
    };

  };
  
}
