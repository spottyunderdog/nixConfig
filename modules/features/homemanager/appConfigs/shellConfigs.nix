{ self, inputs, ... }:
let

  aliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";
    "dir" = "dir --color=auto";
    "vdir" = "vdir --color=auto";
    "rmgarbage" = "sudo nix-collect-garbage -d";
    "optimizestore" = "sudo nix-store --optimise";
    "rebuild-flake" = "sudo nixos-rebuild switch --flake";
    "rebuild" = "sudo nixos-rebuild switch";
    "flakeupdate" = "sudo nix flake update";
    "hw" = "hwinfo --short";
    "jctl" = "journalctl -p 3 -xb";
    "la" = "eza -a --color=always --group-directories-first --icons=always";
    "ll" = "eza -l --color=always --group-directories-first --icons=always";
    "ls" = "eza -al --color=always --group-directories-first --icons=always";
    "lt" = "eza -aT --color=always --group-directories-first --icons=always";
    "tarnow" = "tar -acf";
    "untar" = "tar -zxvf";
    "wget" = "wget -c";
  };

in {

  flake.homeModules.shells = { ... }:{
    imports = [
      self.homeModules.bash
      self.homeModules.fish
      self.homeModules.zsh
    ];
  };

  flake.homeModules.bash = { config, pkgs, lib, ... }: {

    options = {
      bashConfig.enable = lib.mkEnableOption "Bash Configs";
    };

    config = lib.mkIf config.bashConfig.enable {
      programs.bash = {
        enable = true;
        enableCompletion = true;

        historySize = 20000;

        initExtra = "fastfetch";

        shellAliases = aliases;

      };

    };

  };

  flake.homeModules.fish = { pkgs, config, lib, ... }: {

    options = {
      fishConfig.enable = lib.mkEnableOption "Fish Configs";
    };

    config = lib.mkIf config.fishConfig.enable {

      programs.fish = {
        enable = true;
        generateCompletions = true;
        interactiveShellInit = "fastfetch";

        shellAliases = aliases;
      };

    };

  };

  flake.homeModules.zsh = { pkgs, config, lib, ... }: {

    options = {
      zshConfig.enable = lib.mkEnableOption "Zsh Configs";
    };

    config = lib.mkIf config.zshConfig.enable {
      programs.zsh = {
        enable = true;
        autosuggestion = {
          enable = true;
          strategy = [ "history" ];
        };

        history = {
          share = true;
          size = 20000;
        };

        shellAliases = aliases;

        initContent = "fastfetch";

      };
    };
  };

}
