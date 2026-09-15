{ self, inputs, ... }: {

  flake.nixosModules.shells = { config, pkgs, lib, ... }: {

    options = {
      extraShells.enable = lib.mkEnableOption "extra shells";
    };

    config = lib.mkIf config.extraShells.enable {

      programs.zsh.enable = true;
      programs.fish.enable = true;

    };
  };
}