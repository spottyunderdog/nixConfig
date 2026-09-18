{ self, inputs, ...}: {

  flake.nixosModules.fish = { pkgs, config, lib, ... }: {

    options = {
      fish.enable = lib.mkEnableOption "Fish Shell";
    };

    config = lib.mkIf config.fish.enable {
      
      programs.fish = {
        enable = true;
        generateCompletions = true;
        interactiveShellInit = "fastfetch";

        shellAliases = config.home-vars.shell-alias;
      };

    };

  };

}