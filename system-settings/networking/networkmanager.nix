{ self, inputs, ... }: {

  flake.nixosModules.networkmanager = { config, lib, ... }: {

    options = {
      networkmanager.enable = lib.mkEnableOption "Enable Networkmanager";
      wirelessWPA.enable = lib.mkEnableOption "Enable WPA_Supplement (Wireless Xtra)";
    };

    config = lib.mkIf config.networkmanager.enable {
      networking.networkmanager.enable = true;
      networking.wireless.enable = lib.mkIf config.wirelessWPA.enable true;
    };

  };

}