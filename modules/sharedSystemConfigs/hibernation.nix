{ self, inputs, ... }: {

  flake.nixosModules.hibernation = { config, pkgs, lib, ... }: {

    options = {
      hibernation.enable = lib.mkEnableOption "Enable hibernation support";
    };

    config = lib.mkIf config.hibernation.enable {
      powerManagement.enable = true;
      systemd.sleep.settings.Sleep = {
        AllowHibernation = "yes";
        AllowHybridSleep = "yes";
        AllowSuspend = "yes";
        AllowSuspendThenHibernate = "yes";
        HibernateDelaySec = "15min";
      };

    };

  };

}