{ self, inputs, ...}: {

  flake.nixosModules.starship = { pkgs, lib, config, ... }: {

    options = {
      starship.enable = lib.mkEnableOption "starship";
    };

    config = lib.mkIf config.starship.enable {

      environment.systemPackages = [ pkgs.starship ];

    };

  };

}