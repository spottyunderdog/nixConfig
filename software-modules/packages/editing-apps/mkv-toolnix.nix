{ self, inputs, ... }: {

  flake.nixosModules.mkv-toolnix = { config, pkgs, lib, ... }:{

    options = {
      mkv-toolnix.enable = lib.mkEnableOption "MKV Tool Nix (MKV File Utility)";
    };

    config = lib.mkIf config.mkv-toolnix.enable {

      environment.systemPackages = with pkgs; [
        mkvtoolnix
        mkvtoolnix-cli
      ];

    };

  };

}