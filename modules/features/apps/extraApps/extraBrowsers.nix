{ self, inputs, ... }: {

  flake.nixosModules.extraBrowsers = { pkgs, config, lib, ... } : {

    options = {
      vivaldi.enable = lib.mkEnableOption "Vivaldi Browser";
      zen.enable = lib.mkEnableOption "Zen Browser";
    };

    config = {
      environment.systemPackages = with pkgs;
        lib.optional config.vivaldi.enable vivaldi
        ++ lib.optional config.zen.enable inputs.omniflake.flakes.zen-browser-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
      #services.flatpak = lib.mkIf config.flatpak.enable {
      #  packages = []
      #    ++ lib.optional config.zen.enable "app.zen_browser.zen";
      #};
    };

  };

}
