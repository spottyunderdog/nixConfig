{ self, inputs, ... }: {

  flake.nixosModules.cachyos-kernels = { pkgs, config, lib, ... }: {

    nixpkgs.overlays = [ inputs.omniflake.flakes.nix-cachyos-kernel.overlays.pinned ];
    nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
    nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

    imports = [
      self.nixosModules.cachyos-latest
      self.nixosModules.cachyos-lts
      self.nixosModules.cachyos-server
      self.nixosModules.cachyos-hardened
    ];

    # Cachy LTS Kernel Default
    cachyos-lts-kernel.enable = lib.mkDefault false;
    # Cachy Latest Kernel Default
    cachyos-latest-kernel.enable = lib.mkDefault false;
    # Cachy Hardened Kernel Default
    cachyos-hardened-kernel.enable = lib.mkDefault false;
    # Cachy Server Kernel
    cachyos-server-kernel.enable = lib.mkDefault false;

    # Defaults For CachyOS Linux Kernel Latest. Architechture Specific version.
    # If You don't know which version you should use, don't enable them
    # Just use the "cachyOS latest" kernel option it provides all variants.
    # I recommend reading the Cachy OS Wiki if you are interested,
    # The bellow artcile can help you figure out what one to use.
    # Read: https://wiki.cachyos.org/features/optimized_repos/

    # Latest Cachy Kernel
    cachyos-latest-kernel-x86v3.enable = lib.mkDefault false;
    cachyos-latest-kernel-x86v4.enable = lib.mkDefault false;
    cachyos-latest-kernel-zen4.enable = lib.mkDefault false; # Note: Works on both Zen 4 and Zen 5 CPUS

    # LTS Cachy Kernel
    cachyos-lts-kernel-x86v3.enable = lib.mkDefault false;
    cachyos-lts-kernel-x86v4.enable = lib.mkDefault false;
    cachyos-lts-kernel-zen4.enable = lib.mkDefault false;

  };

}
