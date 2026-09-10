{ self, inputs, ... }: {

  flake.nixosModules.linux-kernels = { pkgs, config, lib, ... }: {

    imports = [
      self.nixosModules.linux-6_12
      self.nixosModules.linux-6_18
      self.nixosModules.linux-latest
      self.nixosModules.linux-nix-default
    ];

    linux-nix-default-kernel.enable = lib.mkDefault false;
    linux-latest-kernel.enable = lib.mkDefault false;
    linux-6_12-kernel.enable = lib.mkDefault false;
    linux-6_18-kernel.enable = lib.mkDefault false;

  };

}