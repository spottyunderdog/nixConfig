{
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };


    omniflake = {
      url = "github:fzakaria/omniflake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # To add for non-omniflake branch
    # - Flake Parts (following nixpkgs)
    # - Home Manager (following nixpkgs)
    # - import tree (following nixpkgs)
    # - Silent SDDM (following nixpkgs)
    # - Zen Browser (following nixpkgs)
    # - Remove Omniflake option for cachy kernel

  };

  outputs = inputs: inputs.omniflake.flakes.flake-parts.lib.mkFlake{ inherit inputs; } 
    ( 
      inputs.omniflake.flakes.import-tree [ 
        ./hosts
        ./software-modules 
        ./system-settings 
        ./users
        ./variables
        ./parts.nix 
      ] 
    );
}

