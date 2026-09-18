{ self, inputs, ... }: {

  flake.nixosModules.kcalc = { pkgs, config, lib, ... }: {

    options = {
      kcalc.enable = lib.mkEnableOption "kdePackages.kcalc";
    };

    config = lib.mkIf config.kcalc.enable {

      environment.systemPackages = [ pkgs.kdePackages.kcalc ];

    };

  };

}