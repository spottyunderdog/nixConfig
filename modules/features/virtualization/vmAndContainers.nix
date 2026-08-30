{ self, inputs, ... }: {

  flake.nixosModules.virtualization = { pkgs, lib, config, ... }: {
    
    imports = [
      self.nixosModules.vmwareVMs
      self.nixosModules.virtmanagerVMs
      self.nixosModules.virtualboxVMs
    ];

    vmwareVMs.enable = lib.mkDefault false;
    virtManVMs.enable = lib.mkDefault false;
    virtualboxVMs.enable = lib.mkDefault false;

  };

}
