{ self, inputs, ... }: {

  flake.nixosModules.prismlauncher = { config, lib, pkgs, ... }: {

    options = {
      prismlauncher.enable = lib.mkEnableOption "Prism Launcher";
    };

    config = lib.mkIf config.prismlauncher.enable {

      environment.systemPackages = [ pkgs.prismlauncher ];

    };

  };

}