{ self, inputs, ... }: {

  flake.homeModules.fish = { pkgs, config, lib, ... }: {

    options = {
      fish-config.enable = lib.mkEnableOption "fish User Configs";
    };

    config = lib.mkIf config.fish-config.enable {
      programs.fish = {
        enable = true;
      };

    };

  };

}