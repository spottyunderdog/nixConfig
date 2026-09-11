{ self, inputs, ... }: 
let 
  locale = "en_US.UTF-8";
  timeZone = "America/New_York";
in {

  flake.nixosModules.locale = { config, pkgs, lib, ... }: {

    # Set your time zone.
    time.timeZone = lib.mkDefault timeZone;

    # Select internationalisation properties.
    i18n.defaultLocale = lib.mkDefault locale;

    i18n.extraLocaleSettings = {
      LC_ADDRESS = lib.mkDefault locale;
      LC_IDENTIFICATION = lib.mkDefault locale;
      LC_MEASUREMENT = lib.mkDefault locale;
      LC_MONETARY = lib.mkDefault locale;
      LC_NAME = lib.mkDefault locale;
      LC_NUMERIC = lib.mkDefault locale;
      LC_PAPER = lib.mkDefault locale;
      LC_TELEPHONE = lib.mkDefault locale;
      LC_TIME = lib.mkDefault locale;
    };

  };

}
