{ self, inputs, ... }: {

  flake.nixosModules.eclipseIDE-java = { config, pkgs, lib, ... }: {

    options = {
      eclipseIDE-java.enable = lib.mkEnableOption "Use the Eclipse IDE For Java";
    };

    config = lib.mkIf config.eclipseIDE-java.enable {

      java.enable = lib.mkDefault true;
      environment.systemPackages = [ pkgs.eclipses.eclipse-java ];

    };

  };

}