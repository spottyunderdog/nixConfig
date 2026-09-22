{ self, inputs, ... }: {

  flake.nixosModules.bluetooth = { config, lib, ... }: {

    options = {
      bluetooth.enable = lib.mkEnableOption "Use Bluetooth";
      bluetooth.enable-disconnects-fix = lib.mkEnableOption "Fixes Issue were BT devices may frequently disconnect";
      bluetooth.enable-blueman = lib.mkEnableOption "Enable the Blueman Bluetooth service";
    };

    config = lib.mkIf (config.bluetooth.enable or config.bluetooth.enable-blueman) {
      
      # This is to fix frequent Bluetooth audio dropouts.
      # Only works for  Intel AX210 card: https://nixos.wiki/wiki/Bluetooth
      boot.extraModprobeConfig = lib.mkIf config.bluetooth.enable-disconnects-fix ''
        # Keep Bluetooth coexistence disabled for better BT audio stability
        options iwlwifi bt_coex_active=0
        # Enable software crypto (helps BT coexistence sometimes)
        options iwlwifi swcrypto=1
        # Disable power saving on Wi-Fi module to reduce radio state changes that might disrupt BT
        options iwlwifi power_save=0
        # Disable Unscheduled Automatic Power Save Delivery (U-APSD) to improve BT audio stability
        options iwlwifi uapsd_disable=1
        # Disable D0i3 power state to avoid problematic power transitions
        options iwlwifi d0i3_disable=1
        # Set power scheme for performance (iwlmvm)
        options iwlmvm power_scheme=1
      '';

      services.blueman.enable = lib.mkIf config.bluetooth.enable-blueman true;

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
            Enable = "Source,Sink,Media,Socket";
          };

          Policy = {
            AutoEnable = true;
          };
          
        };
      };

    };

  };

}