{ self, inputs, ... }: {

  flake.nixosModules.evtest = { pkgs, config, lib, ... }: {

    options = {
      evtest.enable = lib.mkEnableOption "evtest";
    };

    config = lib.mkIf config.evtest.enable {

      environment.systemPackages = [ pkgs.evtest ];

    };

  };

}