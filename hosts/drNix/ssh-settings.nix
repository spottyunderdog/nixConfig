{ self, inputs, ... }: {

  flake.nixosModules.drNix-ssh-settings = { pkgs, config, lib, ... }: {

    # SSH Settings
    openSSH.enable = true;
    # Ports Open SSH SHould use
    nix-vars.ssh-ports = lib.mkForce [ ];
    services.openssh.openFirewall = lib.mkForce false;
    nix-vars.allowed-ssh-users = [ "spotty" ];
    sshClient.config = lib.mkForce ''
      Include ${config.sops.templates."ssh-hosts".path}
    '';

    services.openssh.extraConfig = ''
      Include ${config.sops.templates."ssh-port.conf".path}
    '';

    sops.templates."ssh-port.conf" = {
      mode = "0444";
      content = ''
        Port ${config.sops.placeholder."drnix/port"}
        ListenAddress ${config.sops.placeholder."drnix/address"}
      '';
    };

    sops.templates."ssh-hosts" = {
      mode = "0400";
      owner = "spotty";
      content = ''
        Host dino
          HostName ${config.sops.placeholder."drdino/address"}
          Port ${config.sops.placeholder."drdino/port"}
          IdentityFile ${config.sops.placeholder."drdino/ssh"}
          User ${config.sops.placeholder."drdino/user"}
        Host dinotail
          HostName ${config.sops.placeholder."drdino/address"}
          Port ${config.sops.placeholder."drdino/altPort"}
          IdentityFile ${config.sops.placeholder."drdino/ssh"}
          User ${config.sops.placeholder."drdino/user"}
      '';

    };

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
        firewall-cmd --zone=trusted --add-port="$port/tcp"
      '';
      preStop = ''
        port=$(cat ${config.sops.secrets."drnix/port".path})
        firewall-cmd --zone=trusted --remove-port="$port/tcp" || true
      '';
    };

  };

}