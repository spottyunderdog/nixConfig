{ self, inputs, ... }: {

  flake.nixosModules.bottles = { pkgs, config, lib, ... }: {

    options = {
      bottles.enable = lib.mkEnableOption "Bottles";
    };

    config = lib.mkIf config.bottles.enable {

      environment.systemPackages = with pkgs; [ (bottles.override { removeWarningPopup = true; }) ];

    };

  };

}