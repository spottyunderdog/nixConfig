{ self, inputs, ... }: {

  flake.nixosModules.remoteAccessApps = { config, pkgs, lib, ... }: {
    
    options = {
      remoteAccessApps.enable = lib.mkEnableOption "remoteAcces";
    };

    config = lib.mkIf config.remoteAccessApps.enable {

      environment.systemPackages = with pkgs; [
        rustdesk
        sunshine
        moonlight-qt
        tailscale
      ];

    };

  };

}
