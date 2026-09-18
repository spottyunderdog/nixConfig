{ self, inputs, ... }: {

  flake.nixosModules.packages = { pkgs, lib, config, ... }: {

    imports = [
      self.nixosModules.dev-packages
      self.nixosModules.gaming-packages
      self.nixosModules.media-packages
      self.nixosModules.needed-packages
      self.nixosModules.remote-access-packages
      self.nixosModules.utility-packages
      self.nixosModules.extra-packages
      self.nixosModules.editing-packages
      self.nixosModules.flatpak
      self.nixosModules.coms-packages
      self.nixosModules.libre-office
    ];

    dev-packages.enable = lib.mkDefault false;
    gaming-packages.enable = lib.mkDefault false;
    media-packages.enable = lib.mkDefault false;
    needed-packages.enable = lib.mkDefault true;
    remote-access-packages.enable = lib.mkDefault false;
    utility-packages.enable = lib.mkDefault true;
    editing-packages.enable = lib.mkDefault false;
    coms-packages.enable = lib.mkDefault false;
    flatpak.enable = lib.mkDefault false;

  };

}
