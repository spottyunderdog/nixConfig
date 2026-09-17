{ self, inputs, ... }: {

  flake.nixosModules.rustdesk = { config, lib, pkgs, ... }: {

    options = {
      rustdesk.enable = lib.mkEnableOption "RustDesk. RDP Client/Host";
    };

    config = lib.mkIf config.rustdesk.enable {

      environment.systemPackages = [ pkgs.rustdesk ];

    };

  };

}