{ self, inputs, ... }: {

  flake.nixosModules.vscode = { config, lib, pkgs, ... }: {
    
    options = {
      vscode.enable = lib.mkEnableOption "Enable Visual Studio Code";
    };

    config = lib.mkIf config.vscode.enable {
      environment.systemPackages = [ pkgs.vscode ];
    };

  };

}