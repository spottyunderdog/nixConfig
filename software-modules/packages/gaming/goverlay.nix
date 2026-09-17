{ self, inputs, ... }: {

  flake.nixosModules.goverlay = { config, lib, pkgs, ... }: {

    options = {
      goverlay.enable = lib.mkEnableOption "Goverlay (Editor For Proton/Mangohud settings)";
    };

    config = lib.mkIf config.goverlay.enable {

      environment.systemPackages = [ pkgs.goverlay ];

    };

  };

}