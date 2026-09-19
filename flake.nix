{
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    omniflake = {
      url = "github:fzakaria/omniflake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

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

