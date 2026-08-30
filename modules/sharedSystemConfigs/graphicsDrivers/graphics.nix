{ self, inputs, ... }: {

  flake.nixosModules.drivers = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.nvidia
      self.nixosModules.amd
      self.nixosModules.intel
    ];

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    nvidiaDrivers.enable = lib.mkDefault false;
    amdDrivers.enable = lib.mkDefault false;
    intelDrivers.enable = lib.mkDefault false;

  };

}