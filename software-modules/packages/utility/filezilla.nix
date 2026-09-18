{ self, inputs, ... }: {

  flake.nixosModules.filezilla = { pkgs, config, lib, ... }: {

    options = {
      filezilla.enable = lib.mkEnableOption "filezilla";
    };

    config = lib.mkIf config.filezilla.enable {

      environment.systemPackages = [ pkgs.filezilla ];

    };

  };

}