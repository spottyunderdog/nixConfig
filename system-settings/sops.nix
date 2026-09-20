{ self, inputs, ... }: {

  flake.nixosModules.sops = { config, pkgs, ... }: {

    imports = [
      inputs.omniflake.flakes.sops-nix.nixosModules.default
    ];

    sops.defaultSopsFile = ../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml"; 

    sops.age.keyFile = "${config.nix-vars.default-user-path}/.config/sops/age/keys.txt";

    environment.systemPackages = with pkgs; [
      sops
      age
    ];

  };

}