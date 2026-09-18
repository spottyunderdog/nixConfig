{ self, inputs, ... }: {

  flake.homeModules.shell-configs = { osConfig, lib, config, ... }: {

    imports = [
      self.homeModules.bash
      self.homeModules.fish
      self.homeModules.zsh
    ];

    bash-config.enable = lib.mkDefault true;
    fish-config.enable = lib.mkDefault osConfig.fish.enable;
    zsh-config.enable = lib.mkDefault osConfig.zsh.enable;

  };

}