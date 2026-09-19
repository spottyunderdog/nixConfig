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

  };

}