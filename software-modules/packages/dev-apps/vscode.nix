{ self, inputs, ... }: {

  flake.nixosModules.vscode = {
    
    options = {
      vscode.enable = lib.mkEnableOption "Enable Visual Studio Code"
    };

    config = lib.mkIf config.vscode.enable {
      environment.systemPackage = [ pkgs.vscode ];

      programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ] ++ lib.optional config.java.enable vscjava.vscode-java-pack;

      };

    };

  };

}