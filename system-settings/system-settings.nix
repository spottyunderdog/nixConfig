  {self, inputs, ... }: {

  flake.nixosModules.systemSettings = { pkgs, config, lib , ... }: {

    imports = [
      self.nixosModules.boot-loader
      self.nixosModules.virtualization
      self.nixosModules.kernels
      self.nixosModules.display-manager
      self.nixosModules.desktop-enviornments
      self.nixosModules.swap-versions
      self.nixosModules.hibernation
      self.nixosModules.auto-garbage-collection
      self.nixosModules.locale-settings
      self.nixosModules.pipewire
      self.nixosModules.graphics-drivers
      self.nixosModules.home-manager
      self.nixosModules.nix-vars
      self.nixosModules.ssh-server
      self.nixosModules.networking
      self.nixosModules.auto-update
    ];

    # Shells
    programs.bash.enable = true;
    # Enable systemd services in initrd
    boot.initrd.systemd.enable = true;
    # Enable Experimental Features
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    # System State Verion
    system.stateVersion = "26.05";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = lib.mkDefault true;

    # Enable/Disable the firewall
    firewall.enable = lib.mkDefault true;
    # Enable/Disable NetworkManager
    networkmanager.enable = lib.mkDefault true;
    # Enable/Disable Wireless networking via the WPA supplicant
    wirelessWPA.enable = lib.mkDefault false;
    # Enable/Disable Printing
    printing.enable = lib.mkDefault true;
    # Enable/Disable Bluetooth
    bluetooth.enable = lib.mkDefault true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # Uncomment this line if your using multple desktops to ensure that any conflicts between
      # the pinetry package are overidden. Pinentry can be gnome3, qt, or tty
      pinentryPackage = lib.mkForce pkgs.pinentry-qt;
    };

    #########################################################################
    # Other applications that you may want on all hosts but aren't included #
    # in the included modules.                                                 #
    #########################################################################
    environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        capitaine-cursors
        papirus-icon-theme
    ];


    # Defaults
    swap.enable = lib.mkDefault false;
    zswap.enable = lib.mkDefault false;
    zram.enable = lib.mkDefault false;
    hibernation.enable = lib.mkDefault false;
    auto-garbage-collection.enable = lib.mkDefault false;
    # Thunderbolt support
    services.hardware.bolt.enable = lib.mkDefault true;


    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];

    # Enable X11 Windowing System
    services.xserver.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    users.groups.dot-files = {
      name = "dotFiles";
      gid = 1100;
    };

  };

}
