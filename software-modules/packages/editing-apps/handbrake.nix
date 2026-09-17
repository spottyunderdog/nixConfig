{ self, inputs, ... }: {

  flake.nixosModules.handbrake = { pkgs, config, lib, ... }:{

    options = {
      handbrake.enable = lib.mkEnableOption "Hanbrake (Media transcoder)";
    };

    config = lib.mkIf config.handbrake.enable {

      environment.systemPackages = [ pkgs.handbrake ];

    };

  };

}