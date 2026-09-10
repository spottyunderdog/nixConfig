{ self, inputs, ... }: {

  flake.nixosModules.graphics-drivers = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.nvidia-drivers
      self.nixosModules.amd-drivers
      self.nixosModules.intel-drivers
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia-drivers.enable = lib.mkDefault false;
    amd-drivers.enable = lib.mkDefault false;
    intel-drivers.enable = lib.mkDefault false;

  };

}