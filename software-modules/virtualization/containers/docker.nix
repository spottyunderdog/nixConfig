{ self, inputs, ... }: {
    flake.nixosModules.docker = { config, pkgs, lib, ... }: {

      options = {
        docker.enable = lib.mkEnableOption "Add Docker Support";
      };

      config = lib.mkIf config.docker.enable {
        virtualisation.docker = {
          enable = true;

          rootless = {
            enable = true;
            setSocketVariable = true;
          };

        };

      };


    };
}
