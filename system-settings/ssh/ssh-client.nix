{ self, inputs, ... }: {

  flake.nixosModules.ssh-client = { lib, config, ... }: {

    options = {
      sshClient.config = lib.mkOption {
        type = lib.types.str;
        default = null;
      };
    };

    config = lib.mkIf config.openSSH.enable {
      programs.ssh = {
        extraConfig = config.sshClient.config;
      };
    };

  };

}