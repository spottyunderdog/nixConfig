{ self, inputs, ... }: {

  flake.nixosModules.subtitle-editor = { config, lib, pkgs, ... }: {

    options = {
      subtitle-editor.enable = lib.mkEnableOption "Subtitle Editor (Subtitle Editing)";
    };

    config = lib.mkIf config.subtitle-editor.enable {

      environment.systemPackages = [ pkgs.subtitleeditor ];

    };

  };

}