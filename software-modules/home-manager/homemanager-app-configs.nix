{ self, inputs, ... }: {

  flake.homeModules.app-configs = { pkgs, lib, config, osConfig, ... }: {

    imports = [
      # Home Manager app Config files
      self.homeModules.home-vars
      self.homeModules.zed-editor-config
      self.homeModules.starship-config
      self.homeModules.dot-files
      self.homeModules.vscode-config
      self.homeModules.shell-configs
      self.homeModules.gtk-config
    ];

    zed-editor-config.enable = lib.mkDefault osConfig.zed-editor.enable;
    niri-dots.enable = lib.mkDefault osConfig.niri.enable;
    hyprland-dots.enable = lib.mkDefault osConfig.hyprland.enable;
    noctalia-dots.enable = lib.mkOverride 1001 osConfig.noctalia.enable;
    kitty-dots.enable = lib.mkOverride 1001 osConfig.kitty.enable;
    vscode-config.enable = lib.mkDefault osConfig.vscode.enable;

  };

}
