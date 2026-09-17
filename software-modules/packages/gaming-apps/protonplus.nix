{ self, inputs, ... }: {

  flake.nixosModules.protonplus = { pkgs, config, lib, ... }: {

    options = {
      protonplus.enable = lib.mkEnableOption "Proton Plus";
    };

    config = lib.mkIf config.protonplus.enable {

      environment.systemPackages = [ pkgs.protonplus ];

    };

  };

}