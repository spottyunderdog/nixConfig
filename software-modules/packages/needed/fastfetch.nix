{ self, inputs, ...}: {

  flake.nixosModules.fastfetch = { pkgs, lib, config, ... }: {

    options = {
      fastfetch.enable = lib.mkEnableOption "fastfetch";
    };

    config = lib.mkIf config.fastfetch.enable {

      environment.systemPackages = [ pkgs.fastfetch ];

    };

  };

}