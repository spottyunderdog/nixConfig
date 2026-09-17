{ self, inputs, ... }: {

  flake.nixosModules.mangohud = { lib, pkgs, config, ... }: {

    options = {
      mangohud.enable = lib.mkEnableOption "Mangohud";
    };

    config = lib.mkIf config.mangohud.enable {

      environment.systemPackages = [ pkgs.mangohud ];

    };

  };

}