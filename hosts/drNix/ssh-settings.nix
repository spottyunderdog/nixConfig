{ self, inputs, ... }: {

  flake.nixosModules.drNix-ssh-settings = { pkgs, config, lib, ... }: {

    # SSH Settings
    openSSH.enable = true;
    # Ports Open SSH SHould use
    nix-vars.ssh-ports = lib.mkForce [ ];
    services.openssh.openFirewall = lib.mkForce false;
    nix-vars.allowed-ssh-users = [ "spotty" ];

    # Authorized Pub Keys for SSH, For user spotty
    users.users.spotty.openssh.authorizedKeys.keys = [
    	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBTauBq4ZidPBRLW6liPHxtl60U5qitBgF2jYxmskv8G personal-comp"
    ];

     sshClient.config = lib.mkForce ''
       Include ${config.sops.templates."ssh-hosts".path}
     '';

     services.openssh.extraConfig = ''
       Include ${config.sops.templates."ssh-security.conf".path}
     '';

     sops.templates."ssh-security.conf" = {
       mode = "0444";
       content = ''
         ${config.sops.placeholder."ssh/host2/config3"}
         ${config.sops.placeholder."ssh/host2/config8"}
       '';
     };

     sops.templates."ssh-hosts" = {
       mode = "0400";
       owner = "spotty";
       content = ''
         ${config.sops.placeholder."ssh/host1/config0"}
             ${config.sops.placeholder."ssh/host1/config4"}
             ${config.sops.placeholder."ssh/host1/config5"}
             ${config.sops.placeholder."ssh/host1/config6"}
             ${config.sops.placeholder."ssh/host1/config7"}
         ${config.sops.placeholder."ssh/host1/config1"}
             ${config.sops.placeholder."ssh/host1/config2"}
             ${config.sops.placeholder."ssh/host1/config5"}
             ${config.sops.placeholder."ssh/host1/config6"}
             ${config.sops.placeholder."ssh/host1/config7"}
         ${config.sops.placeholder."ssh/host2/config0"}
             ${config.sops.placeholder."ssh/host2/config4"}
             ${config.sops.placeholder."ssh/host2/config5"}
             ${config.sops.placeholder."ssh/host2/config6"}
             ${config.sops.placeholder."ssh/host2/config7"}
         ${config.sops.placeholder."ssh/host2/config1"}
             ${config.sops.placeholder."ssh/host2/config2"}
             ${config.sops.placeholder."ssh/host2/config5"}
             ${config.sops.placeholder."ssh/host2/config6"}
             ${config.sops.placeholder."ssh/host2/config7"}
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
         port=$(cat ${config.sops.secrets."ssh/host2/config3".path})
         firewall-cmd --zone=trusted --add-port="$port/tcp"
       '';
       preStop = ''
         port=$(cat ${config.sops.secrets."ssh/host2/config3".path})
         firewall-cmd --zone=trusted --remove-port="$port/tcp" || true
       '';
     };

  };

}
