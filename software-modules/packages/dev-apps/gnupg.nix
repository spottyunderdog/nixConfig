{ self, inputs, ... }: {

  flake.nixosModules.gnupg = { pkgs, config, lib, ... }: {

    options = {
      gnupg.enable = lib.mkEnableOption "GNUPG";
    };

    config = lib.mkIf config.gnupg.enable {

      environment.systemPackages = [ pkgs.gnupg ];

    };

  };

}