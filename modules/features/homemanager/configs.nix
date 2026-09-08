{ self, inputs, ... }: {

  flake.homeModules.appConfigs = { pkgs, lib, config, ... }: {

    imports = [
      # Home Manager app Config files
      self.homeModules.zed
      self.homeModules.shells
      self.homeModules.starship
      self.homeModules.dotFiles
    ];

    zedConfig.enable = lib.mkDefault false;
    bashConfig.enable = lib.mkDefault false;
    niriConfig.enable = lib.mkDefault false;
    hyprlandConfig.enable = lib.mkDefault false;

    home.pointerCursor = {
      enable = true;
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 24; # Options: 24, 32, 48, etc.
      gtk.enable = true;
      x11.enable = true;
    };

  };

}
