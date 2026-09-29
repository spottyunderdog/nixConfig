{ self, inputs, ... }: {

  flake.homeModules.zen-browser-config = { config, lib, pkgs, ...}: {

    imports = [
      inputs.zen-browser.homeModules.default
    ];

    options = {
      zen-browser-config.enable = lib.mkEnableOption "Zen Configuration";
    };

    config = lib.mkIf config.zen-browser-config.enable {
      
      home.sessionVariables.MOZ_LEGACY_PROFILES = "1";

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        policies = self.homeModules.zen-polices;
          

        profiles.default = {
          mods = [
            "2317fd93-c3ed-4f37-b55a-304c1816819e" # Audio Indicator Enhanced
            "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs 
            "ad97bb70-0066-4e42-9b5f-173a5e42c6fc" # Super Pins
            "d8b79d4a-6cba-4495-9ff6-d6d30b0e94fe" # Better Active Tab
            "c6813222-6571-4ba6-8faf-58f3343324f6" # Disable Rounded Corners
            "58649066-2b6f-4a5b-af6d-c3d21d16fc00" # Private Mode Hightlighting
            "03a8e7ef-cf00-4f41-bf24-a90deeafc9db" # Zen Color Picker
          ];

          search = self.homeModules.zen-search;

          containersForce = true;

          containers = {
            Homwork = {
              color = "blue";
              icon = "purple";
              id = 1;
            };
            Computer = {
              color = "blue";
              icon = "briefcase";
              id = 2;
            };
            Shopping = {
              color = "yellow";
              icon = "shopping cart";
              id = 3;
            };
            Finaces = {
              color = "green";
              icon = "dollar sign";
              id = 4;
            };
            Gaming = {
              color = "purple";
              icon = "fence";
              id = 5;
            };

          };

          settings = {
            "zen.urlbar.behavior" = "normal";
            "zen.urlbar.replace-newtab" = true;
            "zen.workspaces.continue-where-left-off" = true;
            "zen.workspaces.seperate-essentials" = false;
            "zen.view.show-clear-tabs-button" = true;
            "zen.view.use-single-toolbar" = false;
            "zen.view.sidebar-expanded" = true;
            "zen.view.sidebar-expanded.max-width" = 500;
            "zen.welcome-screen.seen" = true;
            "zen.show-newtab-button-top" = true;
            "zen.workspaces.show-workspace-indicator" = true;
            "permissions.default.loopback-network" = 2;
            "permissions.default.local-network" = 2;
            "media.videocontrols.picture-in-picture.enabled" = true;
            "zen.mediacontrols.enabled" = true;
            "browser.toolbars.bookmars.visibility" = true;
          };

          spacesForce = true;

          spaces = {};
        
        };

      };

    };

  };

}