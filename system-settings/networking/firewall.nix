{ self, inputs, ... }: {

  flake.nixosModules.firewall = { lib, config, ... }: {

    options = {
      firewall.enable = lib.mkEnableOption "Enable the firewall";
    };

    config = lib.mkIf config.firewall.enable {
      
      networking.nftables.enable = true;
      services.firewalld.enable = true;

      networking.firewall = {
        enable = true;
        allowedUDPPorts = config.nix-vars.allowedUdp;
        allowedUDPPortRanges = config.nix-vars.allowedUdpRanges;
        allowedTCPPorts = config.nix-vars.allowedTcp;
        allowedTCPPortRanges = config.nix-vars.allowedTcpRanges;
      };

    };

  };

}