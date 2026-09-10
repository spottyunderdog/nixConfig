{
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   
    omniflake = {
      url = "github:fzakaria/omniflake";
      inputs.omniflake.inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs: inputs.omniflake.flakes.flake-parts.lib.mkFlake{inherit inputs;} (inputs.omniflake.flakes.import-tree ./modules);
}

