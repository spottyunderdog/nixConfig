{ self, inputs, ... }: {

  flake.nixosModules.shells = { config, pkgs, lib, ... }: {

    options = {
      extra-shells.enable = lib.mkEnableOption "extra shells";
    };

    config = lib.mkIf config.extra-shells.enable {

      programs.zsh.enable = true;
      programs.fish.enable = true;

    };
  };
}