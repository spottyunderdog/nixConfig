{ self, inputs, ... }: {

  flake.homeModules.vscode-config = { osConfig, config, pkgs, lib, ... }: {

    options = {
      vscode-config.enable = lib.mkEnableOption "Enable VSCode Configs";
    };

    config = lib.mkIf config.vscode-config.enable {
      programs.vscode = {
        enable = true;
        profiles.default.extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ] ++ lib.optional osConfig.java.enable vscjava.vscode-java-pack;

      };
    };

  };

}