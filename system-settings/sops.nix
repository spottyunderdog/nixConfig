{ self, inputs, ... }: {

  flake.nixosModules.sops = { config, pkgs, ... }: {

    imports = [
      inputs.sops-nix.nixosModules.default
    ];

    sops.defaultSopsFile = ../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml"; 

    sops.age.keyFile = "/home/spotty/.config/sops/age/keys.txt";

    sops.secrets."passwords/spotty" = { 
      neededForUsers = true;
    };
    

  };

}