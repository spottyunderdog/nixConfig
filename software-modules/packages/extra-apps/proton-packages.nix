{ self, inputs, ...}: {

  flake.nixosModules.proton-packages = { config, pkgs, lib, ... }: {

    options = {
      proton-packages.enable = lib.mkEnableOption "protonApps";
    };

    config = lib.mkIf config.proton-packages.enable {

      environment.systemPackages = with pkgs; [
        proton-pass
        proton-vpn
        protonmail-desktop
      ];

    };

  };
}
