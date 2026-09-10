{ self, inputs, ... }: {

  flake.nixosModules.sddm = { pkgs, config, lib, ... }: {

    imports = [ self.nixosModules.silentSDDM ];

    options = {
      sddm.enable = lib.mkEnableOption "Display Manager SDDM";
    };

    config = lib.mkIf config.sddm.enable {
      
      services.displayManager.sddm = {
        enable = lib.mkDefault true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
      };
      
      environment.systemPackages = with pkgs;[
        kdePackages.kwin
      ];

    };

  };


};