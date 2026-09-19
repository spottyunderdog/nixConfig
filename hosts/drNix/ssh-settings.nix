{ self, inputs, ... }: {

  flake.nixosModules.drNix-ssh-settings = { pkgs, config, lib, ... }: {

    # SSH Settings
    openSSH.enable = true;
    # Ports Open SSH SHould use
    nix-vars.ssh-ports = [ ];
    services.openssh.openFirewall = false;
    nix-vars.allowed-ssh-users = [ "spotty" ];
    sshClient.config = lib.mkForce ''
      Include ${config.sops.templates."ssh-hosts".path}
    '';

    systemd.services.ssh-port-firewalld = {
      description = "Open secret SSH port in firewalld";
      wantedBy = [ "multi-user.target" ];
      after = [ "firewalld.service" ];
      requires = [ "firewalld.service" ];
      partOf = [ "firewalld.service" ];   # re-run whenever firewalld restarts
      path = [ pkgs.firewalld ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        port=$(cat ${config.sops.secrets."drnix/port".path})
        firewall-cmd --zone=public --add-port="$port/tcp"
      '';
      preStop = ''
        port=$(cat ${config.sops.secrets."drnix/port".path})
        firewall-cmd --zone=public --remove-port="$port/tcp" || true
      '';
    };

  };

}