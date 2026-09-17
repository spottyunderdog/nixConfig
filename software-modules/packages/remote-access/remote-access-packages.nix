{ self, inputs, ... }: {

  flake.nixosModules.remote-access-packages = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.moonlight
      self.nixosModules.rustdesk
      self.nixosModules.sunshine
      self.nixosModules.tailscale
    ];

    options = {
      remote-access-packages.enable = lib.mkEnableOption "remoteAcces";
    };

    config = lib.mkIf config.remote-access-packages.enable {

      moonlight.enable = lib.mkDefault true;
      rustdesk.enable = lib.mkDefault false;
      sunshine.enable = lib.mkDefault true;
      sunshine.autostart = lib.mkDefault false;
      tailscale.enable = lib.mkDefault true;

    };

  };

}
