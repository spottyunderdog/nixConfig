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
  };

}
