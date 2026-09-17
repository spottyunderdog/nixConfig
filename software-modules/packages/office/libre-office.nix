{ self, inputs, ... }: {

  flake.nixosModules.libre-office = { config, pkgs, lib, ... }: {

    options = {
      libre-office.enable = lib.mkEnableOption "Libre Office Suite";
    };

    config = lib.mkIf config.libre-office.enable {

      environment.systemPackages = with pkgs; [
        libreoffice-qt
        hunspell
        hunspellDicts.en-us-large
      ];

    };

  };

}