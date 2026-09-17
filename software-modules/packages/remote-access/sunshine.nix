{ self, inputs, ... }: {

  flake.nixosModules.sunshine = { config, lib, pkgs, ... }: {

    options = {
      sunshine.enable = lib.mkEnableOption "Sunshine, Server client for moonlight";
      sunshine.autostart = lib.mkEnableOption "Wether or not to autostart sunshine at login";
    };

    config = lib.mkIf config.sunshine.enable {

      services.sunshine = {
        enable = true;
        autoStart = config.sunshine.autostart;  # optional: starts Sunshine automatically on login
        capSysAdmin = true;
        openFirewall = true;
      };


    };

  };

}