{ self, inputs, ... }: {

  flake.nixosModules.virtualization = { pkgs, lib, config, ... }: {

    imports = [
      self.nixosModules.vmwareVMs
      self.nixosModules.virtmanagerVMs
      self.nixosModules.virtualboxVMs
      self.nixosModules.docker
    ];

    vmwareVMs.enable = lib.mkDefault false;
    virtManVMs.enable = lib.mkDefault false;
    virtualboxVMs.enable = lib.mkDefault false;
    docker.enable = lib.mkDefault false;
    dockerRootless.enable = lib.mkDefault false;
    dockerRootless.lingering.enable = lib.mkDefault false;

  };

}
