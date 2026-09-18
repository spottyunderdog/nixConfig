{ self, inputs, ... }: {

  flake.nixosModules.easyeffects = { pkgs, config, lib, ... }: {

    options = {
      easyeffects.enable = lib.mkEnableOption "easyeffects";
    };

    config = lib.mkIf config.easyeffects.enable {

      environment.systemPackages = [ pkgs.easyeffects ];

    };

  };

}