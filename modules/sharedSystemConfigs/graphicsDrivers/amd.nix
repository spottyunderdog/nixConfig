{ self, inputs, ... }: {

  flake.nixosModules.amd = { pkgs, config, lib, ... }: {

    options = {
        amdDrivers.enable = lib.mkEnableOption "AMD drivers";
    };

    config = lib.mkIf config.amdDrivers.enable {
      services.xserver.videoDrivers = [ "amdgpu" ];
      boot.initrd.kernelModules = [ "amdgpu" ];
    };

  };
  
}
