{ self, inputs, ... }: {

  flake.nixosModules.virt-manager = { pkgs, lib, config, ... }: {

    options = {
      virt-manager.enable = lib.mkEnableOption "VirtManager";
    };

    config = lib.mkIf config.virt-manager.enable {
      programs.virt-manager.enable = true;
      # Uncomment to mannually add users to the libvirtd group
      # Not recommend, as this is set for you in the user module.
      # users.groups.libvirtd.members = ["spotty"];
      virtualisation.libvirtd.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
    };

  };

}
