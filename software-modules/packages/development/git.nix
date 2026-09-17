{ self, inputs, ... }: {

  flake.nixosModules.git = { pkgs, config, lib, ... }: {

    options = {
      git.enable = lib.mkEnableOption "Use Git";
    };

    config = lib.mkIf config.git.enable {

      environment.systemPackages = [ pkgs.git ];

    };

  };

}