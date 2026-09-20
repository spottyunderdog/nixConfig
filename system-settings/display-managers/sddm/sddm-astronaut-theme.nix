{ self, inputs, ... }: {

  flake.nixosModules.sddm-astronaut-theme = { config, lib, pkgs, ... }: {

    options = {
      astronaut-theme.enable = lib.mkEnableOption "Astronaut Theme";
      astronaut-theme.embeddedTheme = lib.mkOption {
        type = lib.types.str;
        default = "astronaut";
      };
    };

    config = lib.mkIf (config.sddm.enable && config.astronaut-theme.enable) {

      services.displayManager.sddm.theme = "sddm-astronaut-theme";

      environment.systemPackages = with pkgs; [
        (sddm-astronaut.override {
          embeddedTheme = "${config.astronaut-theme.embeddedTheme}";
          themeConfig = {
            HideSystemButtons = "false";
          };


        })
      ];

    };

  };

}