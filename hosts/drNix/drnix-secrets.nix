{ self, inputs, ... }: {

  flake.nixosModules.drNix-secrets = { config, pkgs, lib, ... }: {

    sops.secrets = {
      "passwords/spotty" = {
        sopsFile = ../../secrets/secrets.yaml;
        neededForUsers = true;
      };

      "drdino/address" = {
        sopsFile = ../../secrets/sshhosts.yaml;
      };

      "drdino/port" = {
        sopsFile = ../../secrets/sshhosts.yaml;
      };

      "drdino/altPort" = {
        sopsFile = ../../secrets/sshhosts.yaml;
      };

      "drdino/ssh" = {
        sopsFile = ../../secrets/sshhosts.yaml;
      };

      "drdino/user" = {
        sopsFile = ../../secrets/sshhosts.yaml;
      };

      "drnix/address" = {
        sopsFile = ../../secrets/sshhosts.yaml;
      };

      "drnix/port" = {
        sopsFile = ../../secrets/sshhosts.yaml;
      };

    };

    sops.templates."ssh-hosts" = {
      mode = "0400";
      owner = "spotty";
      content = ''
        Host dino
          HostName ${config.sops.placeholder."drdino/address"}
          Port ${config.sops.placeholder."drdino/port"}
          Key ${config.sops.placeholder."drdino/ssh"}
          User ${config.sops.placeholder."drdino/user"}
        Host dinotail
          HostName ${config.sops.placeholder."drdino/address"}
          Port ${config.sops.placeholder."drdino/altPort"}
          Key ${config.sops.placeholder."drdino/ssh"}
          User ${config.sops.placeholder."drdino/user"}
      '';

    };

  };

}