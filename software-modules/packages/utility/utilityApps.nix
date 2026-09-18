{ self, inputs, ... }: {

  flake.nixosModules.utilityApps = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.bottles
      self.nixosModules.btop
      self.nixosModules.easyeffects
      self.nixosModules.evtest
      self.nixosModules.filelight
      self.nixosModules.filezilla
      self.nixosModules.gparted
      self.nixosModules.kcalc
      self.nixosModules.kde-connect
      self.nixosModules.qbittorrent
      self.nixosModules.smartmontools
      self.nixosModules.upscaler
      self.nixosModules.wine
      self.nixosModules.yazi
    ];

    options = {
      utilityApps.enable = lib.mkEnableOption "utitityApps";
    };

    config = lib.mkIf config.utilityApps.enable {

      bottles.enable = lib.mkDefault true;
      btop.enable = lib.mkDefault true;
      easyeffects.enable = lib.mkDefault true;
      evtest.enable = lib.mkDefault true;
      fastfetch.enable = lib.mkOverride 1001 true;
      filelight.enable = lib.mkDefault true;
      filezilla.enable = lib.mkDefault true;
      gparted.enable = lib.mkDefault true;
      kcalc.enable = lib.mkDefault true;
      kde-connect.enable = lib.mkDefault true;
      kitty.enable = lib.mkOverride 1001 true;
      qbittorrent.enable = lib.mkDefault true;
      smartmontools.enable = lib.mkDefault true;
      upscaler.enable = lib.mkDefault true;
      wine.enable = lib.mkDefault true;
      yazi.enable = lib.mkDefault true;

    };

  };


}
