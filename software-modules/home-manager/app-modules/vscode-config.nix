{ self, inputs, ... }: {

  flake.homeModules.vscode-config = { osConfig, config, pkgs, lib, ... }: {

    options = {
      vscode-config.enable = lib.mkEnableOption "Enable VSCode Configs";
    };

    config = lib.mkIf config.vscode-config.enable {
      # Use VSCodium instead of VSCode to avoid telemetry and proprietary bits
      programs.vscodium = {
        enable = true;
        package = pkgs.vscodium;
        profiles.default.extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ] ++ lib.optional osConfig.java.enable vscjava.vscode-java-pack;

      };
    };

  };

}