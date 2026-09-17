{ self, inputs, ... }: {
  
    flake.nixosModules.umu-launcher = { config, pkgs, lib, ... }: {

        options = {
            umu-launcher.enable = lib.mkEnableOption "Umu Launcher";
        };

        config = lib.mkIf config.umu-launcher.enable {

            environment.systemPackages = [ pkgs.umu-launcher ];

        };

    };

}