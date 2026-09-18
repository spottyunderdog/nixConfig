{ self, inputs, ... }: {

  flake.nixosModules.virtualization = { pkgs, lib, config, ... }: {

    imports = [
      self.nixosModules.vmware
      self.nixosModules.virt-manager
      self.nixosModules.virtualbox
      self.nixosModules.docker
      self.nixosModules.podman
    ];

    vmware.enable = lib.mkDefault false;
    virt-manager.enable = lib.mkDefault false;
    virtualbox.enable = lib.mkDefault false;
    docker.enable = lib.mkDefault false;
    podman .enable = lib.mkDefault false;

  };

}
