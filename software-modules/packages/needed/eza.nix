{ self, inputs, ...}: {

  flake.nixosModules.eza = { pkgs, lib, config, ... }: {

    options = {
      eza.enable = lib.mkEnableOption "eza";
    };

    config = lib.mkIf config.eza.enable {

      environment.systemPackages = [ pkgs.eza ];

    };

  };

}