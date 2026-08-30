{ self, inputs, ... }: {

  flake.nixosModules.editingApps = { config, pkgs, lib, ... }: {

    options = {
      editingApps.enable = lib.mkEnableOption "editingApps";
    };

    config = lib.mkIf config.editingApps.enable {

      environment.systemPackages = with pkgs; [
        subtitleedit
        mkvtoolnix
        mkvtoolnix-cli
        kdePackages.kdenlive
        handbrake
      ];

    };

  };
}