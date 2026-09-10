{ self, inputs, ... }: {

  flake.nixosModules.virtmanagerVMs = { pkgs, lib, config, ... }: {

    options = {
      virtManVMs.enable = lib.mkEnableOption "VirtManager";
    };

    config = lib.mkIf config.virtManVMs.enable {
      programs.virt-manager.enable = true;
      # Uncomment to mannually add users to the libvirtd group
      # Not recommend, as this is set for you in the user module.
      # users.groups.libvirtd.members = ["spotty"];
      virtualisation.libvirtd.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
    };

  };

}
