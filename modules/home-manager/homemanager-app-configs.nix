{ self, inputs, ... }: {

  flake.homeModules.appConfigs = { pkgs, lib, config, ... }: {

    imports = [
      # Home Manager app Config files
      self.homeModules.zed-editor-config
      self.homeModules.shell-config-modules
      self.homeModules.starship-config
      self.homeModules.dot-files
    ];

    zedConfig.enable = lib.mkDefault false;
    bashConfig.enable = lib.mkDefault false;
    niriConfig.enable = lib.mkDefault false;
    hyprlandConfig.enable = lib.mkDefault false;

  };

}
