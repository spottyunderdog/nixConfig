{ self, inputs, ... }: {

  flake.nixosModules.virtualboxVMs = { pkgs, lib, config, ... }: {

    options = {
      virtualboxVMs.enable = lib.mkEnableOption "VirtualBox VMs";
    };

    config = lib.mkIf config.virtualboxVMs.enable {
      virtualisation.virtualbox.host.enable = true;
      # Enable if you need to use the virtualbox extension pack for features like USB 2.0/3.0 support, RDP, disk encryption, NVMe, etc.
      # Requires frequent recompiplations.
      # virtualisation.virtualbox.host.enableExtensionPack = true;

      # Enable if you are running nixos in a virtualbox vm and want to use the guest additions.
      # virtualisation.virtualbox.guest.enable = true;
      # virtualisation.virtualbox.guest.dragAndDrop = true;
    };

  };

}
