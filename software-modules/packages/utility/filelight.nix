{ self, inputs, ... }: {

  flake.nixosModules.filelight = { pkgs, config, lib, ... }: {

    options = {
      filelight.enable = lib.mkEnableOption "filelight";
    };

    config = lib.mkIf config.filelight.enable {

      environment.systemPackages = [ pkgs.kdePackages.filelight ];

    };

  };

}