{ self, inputs, ... }: {

  flake.nixosModules.obs-studio = { config, lib, pkgs, ... }: {

    option = {
      obs-studio.enable = lib.mkEnableOption "Obs Studio";
    };

    config = lib.mkIf config.obs-studio.enable {

      environment.sytemPackages = [ pkgs.obs-studio ];

    };

  };

}