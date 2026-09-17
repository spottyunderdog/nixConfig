{ self, inputs, ... }: {

  flake.nixosModules.vlc = { config, lib, pkgs, ... }: {

    options = {
      vlc.enable = lib.mkEnableOption "Vlc Media Player";
    };

    config = lib.mkIf config.vlc.enable {

      environment.systemPackages = [ pkgs.vlc ];

    };

  };

}