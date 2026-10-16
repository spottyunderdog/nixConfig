{ self, inputs, ... }: {

  flake.nixosModule.vulkan-low-latency-layer = { pkgs, lib, config, ... }: {
    imports = [
      inputs.low-latency-layer.nixosModules.low-latency-layer
    ];

    options = {
      low-latency-layer.enable = lib.mkEnableOption "Korthos Low Latency";
    };

    config = lib.mkIf config.low-latency-layer.enable {

      programs.low-latency-layer.enable = true;

    };

  };

}
