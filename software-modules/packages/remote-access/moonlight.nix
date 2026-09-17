{ self, inputs, ... }: {

  flake.nixosModules.moonlight = { config, lib, pkgs, ... }: {

    options = {
      moonlight.enable = lib.mkEnableOption "Moonlight Client For PC Remote Acces";
    };

    config = lib.mkIf config.moonlight.enable {

      environment.systemPackages = [ pkgs.moonlight-qt ];

    };

  };

}