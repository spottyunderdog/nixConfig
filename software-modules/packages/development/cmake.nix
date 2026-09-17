{ self, inputs, ... }: {

  flake.nixosModules.cmake = { pkgs, config, lib, ... } : {

    options = {
      cmake.enable = lib.mkEnableOption "Use Cmake";
    };

    config = lib.mkIf config.cmake.enable {

      environment.systemPackages = [ pkgs.cmake ];

    };

  };

}