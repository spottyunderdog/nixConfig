{ self, inputs, ... }: {

  flake.nixosModules.flatpak = { config, lib, pkgs, ... }: {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

    options = {
      flatpak.enable = lib.mkEnableOption "Flatpaks";
    };

    config = lib.mkIf config.flatpak.enable {
      services.flatpak.enable = true;
      services.flatpak.update.auto.enable = false;
      services.flatpak.uninstallUnmanaged = false;
      services.flatpak.packages = [
        "com.github.tchx84.Flatseal"
      ];
    };

  };

}
