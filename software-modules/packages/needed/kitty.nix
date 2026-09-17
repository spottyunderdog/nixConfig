{ self, inputs, ...}: {

  flake.nixosModules.kitty = { pkgs, lib, config, ... }: {

    options = {
      kitty.enable = lib.mkEnableOption "kitty";
    };

    config = lib.mkIf config.kitty.enable {

      environment.systemPackages = [ pkgs.kitty ];

    };

  };

}