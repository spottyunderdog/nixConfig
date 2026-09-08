{ self, inputs, ... }: {

  flake.nixosModules.utilityApps = { config, pkgs, lib, ... }: {

    options = {
      utilityApps.enable = lib.mkEnableOption "utitityApps";
    };

    config = lib.mkIf config.utilityApps.enable {

      environment.systemPackages = with pkgs; [
        bottles
        btop
        easyeffects
        filezilla
        gparted
        gparted-full
        kdePackages.filelight
        kdePackages.kcalc
        kdePackages.kdeconnect-kde
        kitty
        qbittorrent
        sublime3
        upscaler
        vim
        wine
        winetricks
        fastfetch
        evtest
        smartmontools
      ];
      
    };

  };


}
