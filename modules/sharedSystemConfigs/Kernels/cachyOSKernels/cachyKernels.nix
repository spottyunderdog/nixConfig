{ self, inputs, ... }: {

  flake.nixosModules.cachyKernels = { pkgs, config, lib, ... }: {

    nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
    nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
    nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

    imports = [
      self.nixosModules.cachyLatest
      self.nixosModules.cachyLts
      self.nixosModules.cachyServer
      self.nixosModules.cachyHardened
    ];

    # Cachy LTS Kernel Default
    cachyLtsKernel.enable = lib.mkDefault false;
    # Cachy Latest Kernel Default
    cachyLatestKernel.enable = lib.mkDefault false;
    # Cachy Hardened Kernel Default
    cachyHardenedKernel.enable = lib.mkDefault false;
    # Cachy Server Kernel
    cachyServerKernel.enable = lib.mkDefault false;

    # Defaults For CachyOS Linux Kernel Latest. Architechture Specific version.
    # If You don't know which version you should use, don't enable them
    # Just use the "cachyOS latest" kernel option it provides all variants.
    # I recommend reading the Cachy OS Wiki if you are interested,
    # The bellow artcile can help you figure out what one to use.
    # Read: https://wiki.cachyos.org/features/optimized_repos/

    # Latest Cachy Kernel
    cachyLatestKernel-x86v3.enable = lib.mkDefault false;
    cachyLatestKernel-x86v4.enable = lib.mkDefault false;
    cachyLatestKernel-zen4.enable = lib.mkDefault false; # Note: Works on both Zen 4 and Zen 5 CPUS

    # LTS Cachy Kernel
    cachyLtsKernel-x86v3.enable = lib.mkDefault false;
    cachyLtsKernel-x86v4.enable = lib.mkDefault false;
    cachyLtsKernel-zen4.enable = lib.mkDefault false;

  };

}
