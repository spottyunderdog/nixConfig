{ self, inputs, ... }: {
    flake.nixosModules.docker = { config, pkgs, lib, ... }: {

      options = {
        docker.enable = lib.mkEnableOption "Add Docker Support";
        dockerRootless.enable = lib.mkEnableOption "Run Rootless";
        dockerRootless.lingering.enable = lib.mkEnableOption "Enable Lingering for Rootless Docker";
      };

      config = lib.mkIf config.docker.enable {
        virtualisation.docker = {
          enable = true;

          rootless = lib.mkIf config.dockerRootless.enable {
            enable = true;
            setSocketVariable = true;
          };

        };

      };


    };
}
