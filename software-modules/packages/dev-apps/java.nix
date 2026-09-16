{ self, inputs, ... }: {

  flake.nixosModules.java = { config, lib, pkgs, ... }:{

    options = {
      java.enable = lib.mkEnableOption "Enable Java";
    };
    
    config = lib.mkIf config.java.enable {

      environment.systemPackages = with pkgs; [ 
        jdk21 
        jdk25 
      ];

    };

  };

}