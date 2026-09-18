{ self, inputs, ... }: {

  flake.nixosModules.upscaler = { pkgs, config, lib, ... }: {

    options = {
      upscaler.enable = lib.mkEnableOption "upscaler";
    };

    config = lib.mkIf config.upscaler.enable {

      environment.systemPackages = [ pkgs.upscaler ];

    };

  };

}