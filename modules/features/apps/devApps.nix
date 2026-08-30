{ self, inputs, ... }: {

  flake.nixosModules.devApps = { config, pkgs, lib, ... }: {

    options = {
      devApps.enable = lib.mkEnableOption "devApps";
    };
    
    config = lib.mkIf config.devApps.enable {

      environment.systemPackages = with pkgs; [
        cmake
        eclipses.eclipse-java
        gnupg
        meld
        vscode
        git
        zed-editor
      ];

    };

  };

}
