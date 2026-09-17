{ self, inputs, ... }: {

  flake.nixosModules.vlc = { config, lib, pkgs, ... }: {

    option = {
      vlc.enable = lib.mkEnableOption "Vlc Media Player";
    };

    config = lib.mkIf config.vlc.enable {

      environment.sytemPackages = [ pkgs.vlc ];

    };

  };

}