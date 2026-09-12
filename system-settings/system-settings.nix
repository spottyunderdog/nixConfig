{self, inputs, ... }: {

  flake.nixosModules.systemSettings = { pkgs, config, lib , ... }: {

    imports = [
      self.nixosModules.boot-loader
      self.nixosModules.virtualization
      self.nixosModules.kernels
      self.nixosModules.display-manager
      self.nixosModules.desktop-enviornments
      self.nixosModules.swap
      self.nixosModules.hibernation
      self.nixosModules.auto-garbage-collection
      self.nixosModules.locale-settings
      self.nixosModules.pipewire
      self.nixosModules.graphics-drivers
      self.nixosModules.home-manager
      self.nixosModules.nix-vars
    ];

    # Thunderbolt support
    services.hardware.bolt.enable = lib.mkDefault true;

    # Shells
    programs.bash.enable = true;

    # Enable systemd services in initrd
    boot.initrd.systemd.enable = true;

    # Enable Experimental Features
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # System State Verion
    system.stateVersion = "26.05";

    # Enable networking
    networking.networkmanager.enable = true;
    # Enables wireless support via wpa_supplicant.
    networking.wireless.enable = true;

    # Enable the firewall and nftables
    networking.firewall.enable = true;
    networking.nftables.enable = lib.mkDefault true;

    # Enable CUPS to print documents.
    services.printing.enable = lib.mkDefault true;

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

    # Enable the OpenSSH daemon.
    services.openssh.enable = lib.mkDefault true;


    #########################################################################
    # Other applications that you may want on all hosts but aren't included #
    # in the included modules.                                                 #
    #########################################################################
    environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        capitaine-cursors
    ];


    # Defaults
    swap.enable = lib.mkDefault false;
    hibernation.enable = lib.mkDefault false;
    auto-garbage-collection.enable = lib.mkDefault false;

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

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

  };

}
