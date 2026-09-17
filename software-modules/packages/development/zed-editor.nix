{ self, inputs, ... }: {

  flake.nixosModules.zed-editor = { config, lib, pkgs, ... }: {

    options = {
      zed-editor.enable = lib.mkEnableOption "Zed Editor";
    };

    config = lib.mkIf config.zed-editor.enable {
      environment.systemPackages = [ pkgs.zed-editor ];
    };

  };

}