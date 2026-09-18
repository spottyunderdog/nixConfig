{ self, inputs, ... }: {

  flake.homeModules.shell-configs = { osConfig, lib, config, ... }: {

    imports = [
      self.homeModules.bash-config
      self.homeModules.fish-config
      self.homeModules.zsh-config
    ];

    bash-config.enable = lib.mkDefault true;
    fish-config.enable = lib.mkDefault osConfig.fish.enable;
    zsh-config.enable = lib.mkDefault osConfig.zsh.enable;

  };

}