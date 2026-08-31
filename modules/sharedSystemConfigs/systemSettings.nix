{self, inputs, ...}:{

  flake.nixosModules.systemSettings = { pkgs, config, lib , ... }: {

    imports = [
      self.nixosModules.bootLoader
      self.nixosModules.virtualization
      self.nixosModules.kernel
      self.nixosModules.displayManager
      self.nixosModules.swap
      self.nixosModules.hibernation
      self.nixosModules.autoGarbageCollection
      self.nixosModules.localeConfiguration
      self.nixosModules.pipewire
      self.nixosModules.users
      self.nixosModules.drivers
    ];

    # Shells
    programs.zsh.enable = true;
    programs.fish.enable = true;
    programs.bash.enable = true;

    # Enable systemd services in initrd
    boot.initrd.systemd.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable networking
    networking.networkmanager.enable = true;

    networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Enable Experimental Features
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable CUPS to print documents.
    services.printing.enable = true;

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
    services.openssh.enable = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.05"; # Did you read the comment?

    # Defaults
    swap.enable = lib.mkDefault false;
    hibernation.enable = lib.mkDefault false;
    autoGarbageCollection.enable = lib.mkDefault false;

    ###################
    # Font Management #
    ###################
    # You may need to make a file called 100-nix.conf with the following in it:
    # <?xml version="1.0"?>
    # <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    # <fontconfig>
    #   <!-- NIX_PROFILE is the path to your Nix profile. See Nix Reference Manual for details. -->
    #   <dir>NIX_PROFILE/lib/X11/fonts</dir>
    #   <dir>NIX_PROFILE/share/fonts</dir>
    # </fontconfig>

    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];

  };

}
