{ self, inputs, ... }: {

  flake.nixosModules.dev-packages = { config, pkgs, lib, ... }: {

    options = {
      dev-packages.enable = lib.mkEnableOption "devApps";
    };

    imports =[
      self.nixosModules.cmake
      self.nixosModules.eclipseIDE-java
      self.nixosModules.git
      self.nixosModules.gnupg
      self.nixosModules.java
      self.nixosModules.meld
      self.nixosModules.vscode
      self.nixosModules.zed-editor
    ];
    
    config = lib.mkIf config.dev-packages.enable {

      cmake.enable = lib.mkDefault true;
      eclipseIDE-java.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      gnupg.enable = lib.mkDefault true;
      java.enable = lib.mkDefault true;
      meld.enable = lib.mkDefault true;
      vscode.enable = lib.mkDefault true;
      zed-editor.enable = lib.mkDefault true;
    };

  };

}
