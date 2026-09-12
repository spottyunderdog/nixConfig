{ self, inputs, ... }: {

  flake.nixosModules.limine = { lib, pkgs, config, ...}: {

    options = {
      limine.enable = lib.mkEnableOption "Limine Bootloader";
    };

    config = lib.mkIf config.limine.enable {

      environment.systemPackages = with pkgs; [
        sbctl
        limine-full
      ];

      boot.loader.limine = {
        enable = true;
        biosDevice = "nodev";
        efiSupport  = true;
        maxGenerations = 100;
        enableEditor = false;
        enrollConfig = true;
        validateChecksums = true;
        panicOnChecksumMismatch = true;
        package = pkgs.limine-full;
        extraEntries = config.nix-vars.limine-entries;
        extraConfig = ''
          remember_last_entry: yes
        '';

        style = {
          interface = {
            branding = "Welcome to NixOS";
            brandingColor = "a6e3a1";
          };

          graphicalTerminal = {
            palette = "1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
            brightPalette = "585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
            background = "aa1e1e2e";
            foreground = "cdd6f4";
            brightBackground = "585b70";
            brightForeground = "cdd6f4";
          };

          wallpaperStyle = "centered";
          wallpapers = [ pkgs.nixos-artwork.wallpapers.catppuccin-mocha.gnomeFilePath ];

        };

        secureBoot = {
          sbctl = pkgs.sbctl;
          enable = true;
          autoGenerateKeys = true;
          autoEnrollKeys = {
            enable = true;
            extraArgs = [ "--microsoft" "--firmware-builtin" ];
          };

        };

      };

    };

  };

}
