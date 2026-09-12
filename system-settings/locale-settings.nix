{ self, inputs, ... }: {

  flake.nixosModules.locale-settings = { config, pkgs, lib, ... }: {
    # Set your time zone.
    time.timeZone = config.nix-vars.time-zone;

    # Select internationalisation properties.
    i18n.defaultLocale = config.nix-vars.locale;

    i18n.extraLocaleSettings = {
      LC_ADDRESS = config.nix-vars.locale;
      LC_IDENTIFICATION = config.nix-vars.locale;
      LC_MEASUREMENT = config.nix-vars.locale;
      LC_MONETARY = config.nix-vars.locale;
      LC_NAME = config.nix-vars.locale;
      LC_NUMERIC = config.nix-vars.locale;
      LC_PAPER = config.nix-vars.locale;
      LC_TELEPHONE = config.nix-vars.locale;
      LC_TIME = config.nix-vars.locale;
    };

  };

}
