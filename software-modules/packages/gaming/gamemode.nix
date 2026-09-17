{ self, inputs, ... }: {

  flake.nixosModules.gamemode = { config, lib, ... }: {

    options = {
      gamemode.enable = lib.mkEnableOption "Enable Gamemode";
    };

    config = lib.mkIf config.gamemode.enable {

      programs.gamemode.enable = true;

    };

  };

}