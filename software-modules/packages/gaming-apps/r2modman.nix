{ self, inputs, ... }: {

  flake.nixosModules.r2modman = { config, lib, pkgs, ... }: {

    options = {
      r2modman.enable = lib.mkEnableOption "R2modman Mod loader";
    };

    config = lib.mkIf config.r2modman.enable {

      environment.systemPackages = [ pkgs.r2modman ];

    };

  };

}