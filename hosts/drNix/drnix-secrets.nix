{ self, inputs, ... }:
let 
  secrets-file1 = ../../secrets/secrets.yaml;
  secrets-file2 = ../../secrets/sshhosts.yaml;
in  {

  flake.nixosModules.drNix-secrets = { ... }: {

    sops.secrets = {
      "passwords/spotty" = {
        sopsFile = secrets-file1;
        neededForUsers = true;
      };

      "drdino/address" = {
        sopsFile = secrets-file2;
      };

      "drdino/port" = {
        sopsFile = secrets-file2;
      };

      "drdino/altPort" = {
        sopsFile = secrets-file2;
      };

      "drdino/ssh" = {
        sopsFile = secrets-file2;
      };

      "drdino/user" = {
        sopsFile = secrets-file2;
      };

      "drnix/address" = {
        sopsFile = secrets-file2;
      };

      "drnix/port" = {
        sopsFile = secrets-file2;
      };

    };

  };

}