{ self, inputs, ... }: {

  flake.nixosModules.extraCosmetics = { config, pkgs, lib, ... }: {

    options = {
      extraCosmetics.enable = lib.mkEnableOption "extra cosmetics";
      millennium.enable = lib.mkEnableOption "millennium";
      vesktop.enable = lib.mkEnableOption "vesktop";
    };

    config = lib.mkIf config.extraCosmetics.enable {

      nixpkgs.overlays = lib.optional config.millennium.enable inputs.millennium.overlays.default;

      environment.systemPackages = with pkgs; []
        ++ lib.optional config.millennium.enable inputs.millennium.packages."${pkgs.stdenv.hostPlatform.system}".millennium-steam
        ++ lib.optional config.vesktop.enable vesktop;
    };

  };

}
