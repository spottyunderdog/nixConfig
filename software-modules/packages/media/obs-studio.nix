{ self, inputs, ... }: {

  flake.nixosModules.obs-studio = { config, lib, pkgs, ... }: {

    options = {
      obs-studio.enable = lib.mkEnableOption "Obs Studio";
    };

    config = lib.mkIf config.obs-studio.enable {

      environment.systemPackages = [ pkgs.obs-studio ];

    };

  };

}