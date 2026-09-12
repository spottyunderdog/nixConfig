{ ... }: {

  flake.homeModules.shell-aliases = { config, lib, ...}: {

    options = {
      home-vars.shell-alias = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {
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
          "checkflake" = "nix flake check --no-build";
          "checkflake-impure" = "nix flake check --no-build --impure";
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

      };

    };
    
  };

}