{ self, inputs, ... }: {

  flake.nixosModules.ssh-server = { lib, config, ... } : {

    imports = [ self.nixosModules.ssh-client ];
    
    options = {
      openSSH.enable = lib.mkEnableOption "Use Open SSH";
    };

    config = lib.mkIf config.openSSH.enable {

      systemd.services.sshd = {
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
      };

      services.openssh = {
        enable = true;
        ports = config.nix-vars.ssh-ports;
        openFirewall = lib.mkDefault false;
        authorizedKeysInHomedir = lib.mkDefault true;
        enableRecommendedAlgorithms = lib.mkDefault true;
        allowSFTP = lib.mkDefault true;
        settings = {
          AllowUsers = config.nix-vars.allowed-ssh-users;
          MaxAuthTries = 6;
          PasswordAuthentication = lib.mkDefault false;
          PermitRootLogin = "no";
          UsePAM = true;
          LogLevel = "INFO";
          StrictModes = true;
          KbdInteractiveAuthentication = false;
        };

      };

    };

  };

}
