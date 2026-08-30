{ self, inputs, ... }: {

  flake.nixosModules.shells = { config, pkgs, lib, ... }: {

    options = {
      extraShells.enable = lib.mkEnableOption "extra shells";
    };

    config = lib.mkIf config.extraShells.enable {

      environment.systemPackages = with pkgs; [
        zsh
        fish
      ];

    };
  };
}