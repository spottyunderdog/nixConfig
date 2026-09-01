{ self, inputs, ... }: {

  flake.nixosModules.neededApps = { config, pkgs, lib, ... }: {

    options = {
      neededApps.enable = lib.mkEnableOption "neededApps";
    };

    config = lib.mkIf config.neededApps.enable {

      environment.systemPackages = with pkgs; [
        alacritty
        curl
        firefox
        git
        gzip
        kitty
        neovim
        wget
        eza
        hwinfo
        fastfetch
        starship
      ];
    };

   };

}
