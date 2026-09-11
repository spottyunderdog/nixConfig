{ self, inputs, ... }: {

  flake.nixosModules.officeSuites = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.libreOffice
      self.nixosModules.onlyOffice
    ];

    libreOffice.enable = lib.mkDefault false;
    onlyOffice.enable = lib.mkDefault false;

  };

  flake.nixosModules.libreOffice = { config, pkgs, lib, ... }: {

    options = {
      libreOffice.enable = lib.mkEnableOption "Libre Office Suite";
    };

    config = lib.mkIf config.libreOffice.enable {

      environment.systemPackages = with pkgs; [
        libreoffice-qt
        hunspell
        hunspellDicts.en-us-large
      ];

    };

  };

  flake.nixosModules.onlyOffice = { config, pkgs, lib, ... }: {
    
    options = {
      onlyOffice.enable = lib.mkEnableOption "OnlyOffice Suite";
    };

    config = lib.mkIf config.onlyOffice.enable {

      environment.systemPackages = with pkgs; [
        onlyoffice-desktopeditors
      ];
    };

  };

}