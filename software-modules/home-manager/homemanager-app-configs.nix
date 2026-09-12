{ self, inputs, ... }: {

  flake.homeModules.app-configs = { pkgs, lib, config, ... }: {

    imports = [
      # Home Manager app Config files
      self.homeModules.home-vars
      self.homeModules.zed-editor-config
      self.homeModules.shell-config-modules
      self.homeModules.starship-config
      self.homeModules.dot-files
    ];

    zed-editor-config.enable = lib.mkDefault false;
    bash-config.enable = lib.mkDefault false;
    fish-config.enable = lib.mkDefault false;
    zsh-config.enable = lib.mkDefault false;
    niri-dots.enable = lib.mkDefault false;
    hyprland-dots.enable = lib.mkDefault false;
    noctalia-dots.enable = lib.mkOverride 1001 false;
    kitty-dots.enable = lib.mkOverride 1001 false;

  };

}
