{ self, inputs, ... }: {

  flake.nixosModules.discord = { config, lib, pkgs, ... }: {

    options = {
      discord.enable = lib.mkEnableOption "Enable Discord";
      vesktop.enable = lib.mkEnableOption "Enable Vesktop";
    };

    config = {
      environment.systemPackages = with pkgs;
        lib.optional (!config.vesktop.enable && config.discord.enable) discord
        ++ lib.optional config.vesktop.enable vesktop;
    };

  };

}