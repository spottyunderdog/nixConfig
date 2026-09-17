{ self, inputs, ... }: {

  flake.nixosModules.remoteAccessApps = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.moonlight
      self.nixosModules.rustdesk
      self.nixosModules.sunshine
      self.nixosModules.tailscale
    ];

    options = {
      remoteAccessApps.enable = lib.mkEnableOption "remoteAcces";
    };

    config = lib.mkIf config.remoteAccessApps.enable {

      moonlight.enable = lib.mkDefault true;
      rustdesk.enable = lib.mkDefault false;
      sunshine.enable = lib.mkDefault true;
      sunshine.autostart = lib.mkDefault false;
      tailscale.enable = lib.mkDefault true;

    };

  };

}
