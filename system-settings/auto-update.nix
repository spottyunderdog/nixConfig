{ self, inputs, ... }: {

  flake.nixosModules.auto-update = { lib, config, ... }: {

    options = {
      auto-update.enable = lib.mkEnableOption "Auto Update the Flake";
    };

    config = lib.mkIf config.auto-update.enable {

      system.autoUpgrade = {
        enable = true;
        flake = "${config.nix-vars.install-dir}/nixConfig#${config.nix-vars.hostname}";
        flags = [
          "--print-build-logs"
          "--commit-lock-file"
        ];
        dates = "09:00";
        allowReboot = true;
        persistent = true;
        runGarbageCollection = true;
        upgrade = false;
        
      };

    };


  };

}