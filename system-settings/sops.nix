{ self, inputs, ... }: {

  flake.nixosModules.sops = { config, lib, pkgs, ... }: {

    options = {
        sops.keyPath = lib.mkOption {
            type = lib.types.path;
            default = "/home/spotty/.config/sops/age/keys.txt";
        };
    };

    imports = [
      inputs.omniflake.flakes.sops-nix.nixosModules.default
    ];
    config = {
        sops.defaultSopsFile = ../secrets/secrets.yaml;
        sops.defaultSopsFormat = "yaml";

        sops.age.keyFile = "${config.sops.keyPath}";

        environment.systemPackages = with pkgs; [
          sops
          age
        ];
    };

  };

}