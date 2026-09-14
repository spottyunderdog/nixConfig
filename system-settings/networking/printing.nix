{ self, inputs, ... }: {

  flake.nixosModules.printing = { config, lib, pkgs, ... }: {

    options = {
      printing.enable = lib.mkEnableOption "Printing Support";
    };
    
    config = lib.mkIf config.printing.enable {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      services.printing = {
        enable = true;
        drivers = with pkgs; [
          cups-filters
          cups-browsed
        ];
      };

    };

  };

}