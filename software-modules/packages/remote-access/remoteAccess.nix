{ self, inputs, ... }: {

  flake.nixosModules.remoteAccessApps = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.tailscale
    ];

    options = {
      remoteAccessApps.enable = lib.mkEnableOption "remoteAcces";
    };

    config = lib.mkIf config.remoteAccessApps.enable {

      tailscale.enable = lib.mkDefault true;

      environment.systemPackages = with pkgs; [
        rustdesk
        sunshine
        moonlight-qt
      ];

    };

  };

  flake.nixosModules.tailscale = { config, pkgs, lib, ... }: {
    
    options = {
      tailscale.enable = lib.mkEnableOption "tailscale";
    };

    config = lib.mkIf config.tailscale.enable {

      services.tailscale = {
        enable = true;
      };

      networking.firewall = {
        trustedInterfaces = [ config.services.tailscale.interfaceName ];
        allowedUDPPorts = [ config.services.tailscale.port ];
      };

      systemd.services.tailscaled.serviceConfig.Environment = [ 
        "TS_DEBUG_FIREWALL_MODE=nftables" 
      ];

      systemd.network.wait-online.enable = false; 
      boot.initrd.systemd.network.wait-online.enable = false;


    };

  };


}
