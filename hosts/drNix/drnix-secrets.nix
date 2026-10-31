{ self, inputs, ... }:
let 
  secrets-file1 = ../../secrets/secrets.yaml;
in  {

  flake.nixosModules.drNix-secrets = { ... }: {

    sops.secrets = {
      "passwords/spotty" = {
        sopsFile = secrets-file1;
        neededForUsers = true;
      };
      "ssh/host1/config0" = {};
      "ssh/host1/config1" = {};
      "ssh/host1/config2" = {};
      "ssh/host1/config3" = {};
      "ssh/host1/config4" = {};
      "ssh/host1/config5" = {};
      "ssh/host1/config6" = {};
      "ssh/host1/config7" = {};
      "ssh/host1/config8" = {};
      "ssh/host2/config0" = {};
      "ssh/host2/config1" = {};
      "ssh/host2/config2" = {};
      "ssh/host2/config3" = {};
      "ssh/host2/config4" = {};
      "ssh/host2/config5" = {};
      "ssh/host2/config6" = {};
      "ssh/host2/config7" = {};
      "ssh/host2/config8" = {};

    };

  };

}
