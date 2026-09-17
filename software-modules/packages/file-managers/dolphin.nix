{ self, inputs, ...}: {

  flake.nixosModules.dolphin = { config, lib, pkgs, ... }: {

    options = {
      dolphin.enable = lib.mkEnableOption "Dolphin File Manager";
    };

    config = lib.mkIf config.dolphin.enable {

      environment.systemPackages = with pkgs; [
        kdePackages.dolphin
        # Svg support
        kdePackages.qtsvg
        # Mounting Network Shares
        kdePackages.kio
        kdePackages.kio-fuse
        kdePackages.kio-extras
      ];

    };

  };

}