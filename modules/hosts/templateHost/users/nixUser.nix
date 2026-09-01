{ self, inputs, ... }:

let

  userName = "nix";
  hostName = "example";

in {

  flake.nixosModules."${hostName}-${userName}" = { config, pkgs, lib, ... }: {

    # Define a user account. Don't forget to set a password with ‘passwd’
    users.users.${userName} = {
      isNormalUser = true;
      description = userName;

      # read here: https://wiki.nixos.org/wiki/User_management
      # Paswords not included in repo/flake.
      # Allows for declaritive password management.
      # hashedPassword = <paswordhash>;

      # Remove the libvirtd group and vboxusers groups 
      # if you don't want the user to have access to vm software
      extraGroups = [ "networkmanager" "wheel" ]
      ++ lib.optional config.virtManVMs.enable "libvirtd" 
      ++ lib.optional config.virtualboxVMs.enable "vboxusers";

      # Choose your shell, If using Fish or ZSH make sure to enable the extra shells module
      # For your host
      shell = pkgs.bash;

      # user specific programs.
      packages = with pkgs; [
        #  thunderbird
      ];
    };

    home-manager.users.${userName} = self.homeModules."${hostName}-${userName}Module";

  };

  flake.homeConfigurations.${userName} = inputs.home-manager.lib.homeManagerConfiguration {

    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };

    modules = [
      self.homeModules."${hostName}-${userName}Module"
      {
        home.username = userName;
        home.homeDirectory = "/home/${userName}";
      }
    ];

  };

  flake.homeModules."${hostName}-${userName}Module" = { pkgs, ... }: {

    imports = [
      self.homeModules.appConfigs
    ];
    # ensures fonts can properly be configured when rebuild your system. 
    # Do not remove.
    xdg.configFile."fontconfig/conf.d/10-hm-fonts.conf".force = true;

    # Shell Configs, Requires utilityApps.enable to be enabled, do to using the
    # fastfetch package in the shells.
    
    bashConfig.enable = false;
    fishConfig.enable = false;
    zshConfig.enable = false;

    # Enable the starship prompt. Will activate for all
    # Shells
    starshipConfig.enable = false;

    # Enable My Niri + Noctalia dot files
    # Also enables kitty dots. Dots use the kitty
    # Terminal, you may need to enable utilityApps 
    # to use.
    niriConfig.enable = false;

    # Enable My Hyprland + Nocatlia dotfiles
    # Also enables kitty dots. Dots use the kitty
    # Terminal, you may need to enable utilityApps 
    # to use.
    hyprlandConfig.enable = false;

    # Enable My Noctalia dotfiles
    noctaliaConfig.enable = false;

    # My Kitty config.
    kittyConfig.enable = false;

    # My Zed Editor config.
    zedConfig.enable = false;

    home.packages = [ ];
    home.stateVersion = "26.05";

  };

}
