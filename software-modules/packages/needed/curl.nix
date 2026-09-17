{ self, inputs, ...}: {

  flake.nixosModules.curl = { pkgs, lib, config, ... }: {

    options = {
      curl.enable = lib.mkEnableOption "Curl";
    };

    config = lib.mkIf config.curl.enable {

      environment.systemPackages = [ pkgs.curl ];

    };

  };

}