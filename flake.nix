{
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # silentSDDM = {
    #   url = "github:uiriansan/SilentSDDM";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # zen-browser = {
    #   url = "github:0xc000022070/zen-browser-flake";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #   };
    # };

    ################################################
    # Omni flake Included stuff                    #
    # This is for spotty's purposes when he pushes #
    # The refactor-testing branch to the main ones #
    ################################################

    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # flake-parts = {
    #   url = "github:vic/import-tree";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # import-tree = {
    #   url = "github:denful/import-tree";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

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

