{ self, inputs, ... }: {

  flake.nixosModules.meld = { config, lib, pkgs, ... }: {

    options = {
      meld.enable = lib.mkEnableOption "Enable Meld";
    };

    config = lib.mkIf config.meld.enable {

      environment.systemPackages = [ pkgs.meld ];

    };

  };

}