{ self, inputs, ... }: {

  flake.nixosModules.heroic = { config, lib, pkgs, ... }: {

    options = {
      heroic.enable = lib.mkEnableOption "Heroic Launcher";
    };

    config = lib.mkIf config.heroic.enable {

      environment.systemPackages = with pkgs; [ 
        (heroic.override {
          extraPkgs = pkgs': with pkgs'; [
            gamescope
            gamemode
          ];
        })
      ];

    };

  };

}