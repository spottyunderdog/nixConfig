{ self, inputs, ...}: {

  flake.nixosModules.neovim = { pkgs, lib, config, ... }: {

    options = {
      neovim.enable = lib.mkEnableOption "neovim";
    };

    config = lib.mkIf config.neovim.enable {

      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
      };

    };

  };

}