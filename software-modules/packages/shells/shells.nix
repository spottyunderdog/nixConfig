{ self, inputs, ... }: {

  flake.nixosModules.shells = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.bash
      self.nixosModules.fish
      self.nixosModules.zsh
    ];

    options = {
      extra-shells.enable = lib.mkEnableOption "extra shells";
    };

    config = lib.mkIf config.extra-shells.enable {

      fish.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;

    };

  };

}