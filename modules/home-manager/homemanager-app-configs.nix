{ self, inputs, ... }: {

  flake.homeModules.app-configs = { pkgs, lib, config, ... }: {

    imports = [
      # Home Manager app Config files
      self.homeModules.zed-editor-config
      self.homeModules.shell-config-modules
      self.homeModules.starship-config
      self.homeModules.dot-files
    ];

    zedConfig.enable = lib.mkDefault false;
    bashConfig.enable = lib.mkDefault false;
    niri-dots.enable = lib.mkDefault false;
    hyprland-dots.enable = lib.mkDefault false;

  };

}
