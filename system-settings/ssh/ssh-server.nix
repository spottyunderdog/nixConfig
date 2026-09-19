{ self, inputs, ... }: {

  flake.nixosModules.ssh-server = { lib, config, ... } : {

    imports = [ self.nixosModules.ssh-client ];
    
    options = {
      openSSH.enable = lib.mkEnableOption "Use Open SSH";
    };

    config = lib.mkIf config.openSSH.enable {

      services.openssh = {
        enable = true;
        ports = config.nix-vars.ssh-ports;
        openFirewall = lib.mkDefault false;
        authorizedKeysInHomedir = true;
        enableRecommendedAlgorithms = true;
        settings = {
          AllowUsers = config.nix-vars.allowed-ssh-users;
          MaxAuthTries = 6;
          PasswordAuthentication = false;
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
