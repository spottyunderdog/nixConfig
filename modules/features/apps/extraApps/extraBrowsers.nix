{ self, inputs, ... }: {

  flake.nixosModules.extraBrowsers = { pkgs, config, lib, ... } : {

    options = {
      vivaldi.enable = lib.mkEnableOption "Vivaldi Browser";
      zen.enable = lib.mkEnableOption "Zen Browser";
    };

    config = {
      environment.systemPackages = with pkgs;
        lib.optional config.vivaldi.enable vivaldi;
      services.flatpak = lib.mkIf config.flatpak.enable {
        packages = []
          ++ lib.optional config.zen.enable "app.zen_browser.zen";
      };
    };

  };

}
