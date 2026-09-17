{ self, inputs, ... }: {

  flake.nixosModules.protontricks = { pkgs, config, lib, ... }: {

    options = {
      protontricks.enable = lib.mkEnableOption "Proton Tricks";
    };

    config = lib.mkIf config.protontricks.enable {

      environment.systemPackages = [ pkgs.protontricks ];

    };

  };

}