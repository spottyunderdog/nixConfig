{ self, inputs, ... }: {

  flake.nixosModules.steam = { pkgs, lib, config, ... }: {

    options = {
      steam.enable = lib.mkEnableOption "Steam";
      millennium.enable = lib.mkEnableOption "Millenium Steam Hombrew";
    };

    config = lib.mkIf (config.steam.enable || config.millennium.enable) {

      nixpkgs.overlays = lib.optional config.millennium.enable inputs.millennium.overlays.default;

      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
          dwproton-bin
        ];
        gamescopeSession.enable = true;
        package = if (config.millennium.enable or false) then pkgs.millennium-steam else pkgs.steam;
      };

    };


  };

}