{ self, inputs, ... }:

let

  userName = "spotty";
  uuid = 1000;

in {

  flake.nixosModules."user-${userName}" = { config, pkgs, lib, ... }: {

    # Creates a user group for the user that matches the username and uid
    users.groups.${userName} = {
      name = userName;
      gid = uuid;
     };

    # Define a user account. Don't forget to set a password with ‘passwd’
    users.users.${userName} = {
      isNormalUser = true;
      description = userName;
      uid = uuid;

      # read here: https://wiki.nixos.org/wiki/User_management
      # Paswords not included in repo/flake.
      # Allows for declaritive password management.
      hashedPasswordFile = config.sops.secrets."passwords/spotty".path;

      group = userName;

      # Remove the libvirtd group and vboxusers groups 
      # if you don't want the user to have access to vm software
      extraGroups = [ "networkmanager" "wheel" "dotFiles" ]
      ++ lib.optional config.virt-manager.enable "libvirtd" 
      ++ lib.optional config.virtualbox.enable "vboxusers";

      linger = if ( config.docker.enable or config.podman.enable or false ) then true else false;

      # Choose your shell, If using Fish or ZSH make sure to enable the extra shells module
      # For your host
      shell = pkgs.fish;

      # user specific programs.
      packages = with pkgs; [
        #  thunderbird
      ];
    };

    home-manager.users.${userName} = self.homeModules."${userName}Module";

  };

  flake.homeConfigurations.${userName} = inputs.home-manager.lib.homeManagerConfiguration {

    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };

    modules = [
      self.homeModules."${userName}Module"
      {
        home.username = userName;
        home.homeDirectory = "/home/${userName}";
      }
    ];

  };

  flake.homeModules."${userName}Module" = { pkgs, ... }: {

    imports = [
      self.homeModules.app-configs
    ];
    # ensures fonts can properly be configured when rebuild your system. 
    # Do not remove.
    # xdg.configFile."fontconfig/conf.d/10-hm-fonts.conf".force = true;

    # Enable the starship prompt. Will activate for all
    # Shells
    starship-config.enable = true;

    # Enable My Niri + Noctalia dot files
    # Also enables kitty dots. Dots use the kitty
    # Terminal, you may need to enable utilityApps 
    # to use.
    niri-dots.enable = true;

    # Enable My Hyprland + Nocatlia dotfiles
    # Also enables kitty dots. Dots use the kitty
    # Terminal, you may need to enable utilityApps 
    # to use.
    hyprland-dots.enable = false;

    # Enable My Noctalia dotfiles
    noctalia-dots.enable = true;

    # My Kitty config.
    kitty-dots.enable = true;

    # My Zed Editor config.
    zed-editor-config.enable = true;

    # My VS Code Config
    vscode-config.enable = true;

    home.packages = [ ];
    home.stateVersion = "26.05";

  };

}
