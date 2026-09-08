{ self, inputs, ... }: {

  flake.nixosModules.displayManager = { pkgs, config, lib, ... }: {

    imports = [
      inputs.silentSDDM.nixosModules.default
      self.nixosModules.x11
      self.nixosModules.wayland
    ];

    services.displayManager.defaultSession = lib.mkForce "plasma";
    services.displayManager.sddm.enable = lib.mkOverride 1000 true;

    programs.silentSDDM = {
      enable = true;
      theme = "rei";
    };

    # Enable X11 Winowing System
    services.xserver.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

  };

}
