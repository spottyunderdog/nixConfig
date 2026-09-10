{self, inputs, ...}: {

  flake.nixosModules.niri = { config, pkgs, lib, ... }: {

    imports = [
      inputs.noctalia.nixosModules.default
    ];

    options = {
      niri.enable = lib.mkEnableOption "Enable the Niri Desktop Environment.";
    };

    config = lib.mkIf config.niri.enable {

      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
      };

      programs.niri.enable = true;
      programs.noctalia = {
        enable = true;
        recommendedServices.enable = true;
      };

    };

  };

}
