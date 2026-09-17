{ self, inputs, ... }: {

  flake.nixosModules.gamescope = { config, lib, pkgs, ... }: {

    options = {
      gamescope.enable = lib.mkEnableOption "Enable Gamescope";
    };

    config = lib.mkIf config.gamescope.enable {

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
        ] ++ lib.optional config.mangohud.enable "--mangoapp";

      };

    };

  };

}