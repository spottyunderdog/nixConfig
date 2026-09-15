{ self, inputs, ... }: {

  flake.nixosModules.gamingApps = { config, pkgs, lib, ... }: {
    
    options = {
      gamingApps.enable = lib.mkEnableOption "gamingApps";
    };
    
    config = lib.mkIf config.gamingApps.enable {
      
      environment.systemPackages = with pkgs; [
        wine
        winetricks
        goverlay
        heroic
        lutris
        mangohud
        protontricks
        prismlauncher
        protonplus
        r2modman
        umu-launcher
      ];

      programs.gamemode.enable = true;
      
      programs.gamescope = {
        enable = true;
        # enableWsi = true; # Can only be enabled in The Unstable Branches
        env = lib.mkIf config.hardware.nvidia.prime.offload.enable {
          __NV_PRIME_RENDER_OFFLOAD = "1";
          __VK_LAYER_NV_optimus = "NVIDIA_only";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        };

        args = [
          "-f"
          "-F" 
          "fsr"
          "--mangoapp"
        ];

      };

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
