{ self, inputs, ... }: {

  flake.nixosModules.obsidian = { config, lib, pkgs, ... }: {

    options = {
      obsidian.enable = lib.mkEnableOption "Obsidian (Note Taking software)";
    };

    config = lib.mkIf config.obsidian.enable {

      environment.systemPackages = [ pkgs.obsidian ];
      
    };

  };

}