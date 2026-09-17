{ self, inputs, ... }: {

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