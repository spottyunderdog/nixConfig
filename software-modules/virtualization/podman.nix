{ self, inputs, ... }: {

  flake.nixosModules.podman = { config, pkgs, lib, ... }: {

    options = {
      podman.enable = lib.mkEnableOption "Add Podman Container Supports";
    };

    config = lib.mkIf config.podman.enable {

      docker.enable = lib.mkForce false;

      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      environment.systemPackages = with pkgs; [
        podman-compose
        docker-compose
        podman-desktop
      ];

      # Creates a system service that starts all containers when the user logs in
      systemd.user.services.podman-start = {
        description = "Podman Start All Containers";
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        wantedBy = [ "default.target" ];
        startLimitIntervalSec = 0;
        enable = true;

        environment = {
          LOGGING = "--log-level=info";
          PATH = lib.mkForce "/run/wrappers/bin:${pkgs.podman}/bin:${pkgs.shadow}/bin:/run/current-system/sw/bin";
        };

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${pkgs.podman}/bin/podman $LOGGING start --all --filter should-start-on-boot=true";
          ExecStop = "${pkgs.podman}/bin/podman $LOGGING stop --service --all";
        };

      };
 
    };

  };

}