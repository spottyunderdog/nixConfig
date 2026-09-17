{ self, inputs, ...}: {

  flake.nixosModules.gzip = { pkgs, lib, config, ... }: {

    options = {
      gzip.enable = lib.mkEnableOption "gzip";
    };

    config = lib.mkIf config.gzip.enable {

      environment.systemPackages = [ pkgs.gzip ];

    };

  };

}