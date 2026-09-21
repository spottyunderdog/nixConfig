{ self, inputs, ... }: {

  flake.nixosModules.editing-packages = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.handbrake
      self.nixosModules.kdenlive
      self.nixosModules.mkv-toolnix
      self.nixosModules.subtitle-editor
    ];

    options = {
      editing-packages.enable = lib.mkEnableOption "editingApps";
    };

    config = lib.mkIf config.editing-packages.enable {

      handbrake.enable = lib.mkDefault true;
      kdenlive.enable = lib.mkDefault true;
      mkv-toolnix.enable = lib.mkDefault true;
      subtitle-editor.enable = lib.mkDefault true;

    };

  };
}