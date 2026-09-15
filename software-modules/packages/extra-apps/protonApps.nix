{ self, inputs, ...}: {

  flake.nixosModules.protonApps = { config, pkgs, lib, ... }: {

    options = {
      protonApps.enable = lib.mkEnableOption "protonApps";
    };

    config = lib.mkIf config.protonApps.enable {

      environment.systemPackages = with pkgs; [
        proton-pass
        proton-vpn
        protonmail-desktop
      ];

    };

  };
}
