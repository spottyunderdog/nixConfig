{ self, inputs, ... }: {

  flake.nixosModules.gparted = { pkgs, config, lib, ... }: {

    options = {
      gparted.enable = lib.mkEnableOption "gparted";
    };

    config = lib.mkIf config.gparted.enable {

      environment.systemPackages = [ pkgs.gparted-full ];

    };

  };

}