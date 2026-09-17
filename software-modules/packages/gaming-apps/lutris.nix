{ self, inputs, ... }: {

  flake.nixosModules.lutris = { config, pkgs, lib, ... }: {

    options = {
      lutris.enable = lib.mkEnableOption "Lutris Launcher";
    };

    config = lib.mkIf config.lutris.enable {

      environment.systemPackages = [ pkgs.lutris ];

    };

  };

}