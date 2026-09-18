{ self, inputs, ... }: {

  flake.nixosModules.bash = { config, pkgs, lib, ... }: {

    options = {
      bashPrompt.enableStarship = lib.mkEnableOption ""; 
    };

    config = {
      programs.bash = {
        enable = true;
        
        completion.enable = true;

        shellInit = "fastfetch";

        # promptInit = lib.mkIf (!bashPrompt) "";

        shellAliases = config.nix-vars.shell-alias;

        undistractMe.enable = true;

      };

    };

  };

}