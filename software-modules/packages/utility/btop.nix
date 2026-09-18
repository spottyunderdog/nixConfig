{ self, inputs, ... }: {

  flake.nixosModules.btop = { pkgs, config, lib, ... }: {

    options = {
      btop.enable = lib.mkEnableOption "btop";
    };

    config = lib.mkIf config.btop.enable {

      environment.systemPackages = [ pkgs.btop ];

    };

  };

}