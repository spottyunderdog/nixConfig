{ self, inputs, ... }: {

  flake.nixosModules.wine = { pkgs, config, lib, ... }: {

    options = {
      wine.enable = lib.mkEnableOption "Wine & Winetricks";
    };

    config = lib.mkIf config.wine.enable {

      environment.systemPackages = with pkgs; [
        wine
        winetricks
      ];

    };

  };

}