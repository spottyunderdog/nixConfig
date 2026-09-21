{ self, inputs, ... }: {

  flake.nixosModules.virt-manager = { pkgs, lib, config, ... }: {

    options = {
      virt-manager.enable = lib.mkEnableOption "VirtManager";
    };

    config = lib.mkIf config.virt-manager.enable {

      programs.virt-manager.enable = true;
      virtualisation.libvirtd.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;

    };

  };

}
