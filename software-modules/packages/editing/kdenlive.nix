{ self, inputs, ... }: {

  flake.nixosModules.kdenlive = { config, pkgs, lib, ... }: {

    options = {
      kdenlive.enable = lib.mkEnableOption "Kden Live (Video Editor)";
    };

    config = lib.mkIf config.kdenlive.enable {

      environment.systemPackages = [ pkgs.kdePackages.kdenlive ];

    };

  };

}