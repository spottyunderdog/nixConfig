{ self, inputs, ...}: {

  flake.nixosModules.kate = { pkgs, lib, config, ... }: {

    options = {
      kate.enable = lib.mkEnableOption "kate";
    };

    config = lib.mkIf config.kate.enable {

      environment.systemPackages = [ pkgs.kdePackages.kate ];

    };

  };

}