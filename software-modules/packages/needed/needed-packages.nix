{ self, inputs, ... }: {

  flake.nixosModules.needed-packages = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.browsers
      self.nixosModules.curl
      self.nixosModules.eza
      self.nixosModules.fastfetch
      self.nixosModules.file-managers
      self.nixosModules.gzip
      self.nixosModules.hwinfo
      self.nixosModules.kate
      self.nixosModules.kitty
      self.nixosModules.neovim
      self.nixosModules.starship
      self.nixosModules.wget
    ];

    options = {
      needed-packages.enable = lib.mkEnableOption "needed-packages";
    };

    config = lib.mkIf config.needed-packages.enable {

      curl.enable = lib.mkDefault true;
      dolphin.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      fastfetch.enable = lib.mkDefault true;
      firefox.enable = lib.mkDefault true;
      git.enable = lib.mkOverride 1001 true;
      gzip.enable = lib.mkDefault true;
      hwinfo.enable = lib.mkDefault true;
      kate.enable = lib.mkDefault true;
      kitty.enable = lib.mkDefault true;
      neovim.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      thunar.enable = lib.mkDefault false;
      vivaldi.enable = lib.mkDefault false;
      wget.enable = lib.mkDefault true;
      zen.enable = lib.mkDefault false;

    };

   };

}
