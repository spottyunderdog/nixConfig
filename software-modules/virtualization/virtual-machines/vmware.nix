{ self, inputs, ... }: {

  flake.nixosModules.vmware = { pkgs, lib, config, ... }: {

    options = {
      vmware.enable = lib.mkEnableOption "enables VMWare Workstation, & virtualization";
    };

    config = lib.mkIf config.vmware.enable  {
       virtualisation.vmware.host.enable = true;

       environment.systemPackages = with pkgs; [
         vmware-workstation
       ];

    };

  };

}
